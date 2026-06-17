const express = require('express');
const http = require('http');
const { Pool, Client } = require('pg');
const cors = require('cors');
const path = require('path');
const { WebSocketServer, WebSocket } = require('ws');
require('dotenv').config();

// Helper to strip surrounding quotes from env vars (handles both Docker and non-Docker environments)
const stripQuotes = (value) => {
  if (!value) return value;
  const str = String(value).trim();
  if ((str.startsWith('"') && str.endsWith('"')) || (str.startsWith("'") && str.endsWith("'"))) {
    return str.slice(1, -1);
  }
  return str;
};

// Strip quotes from env vars that might have them
const dbPassword = stripQuotes(process.env.DB_PASSWORD);
const dbHost = stripQuotes(process.env.DB_HOST);
const dbPort = stripQuotes(process.env.DB_PORT);
const dbName = stripQuotes(process.env.DB_NAME);
const dbUser = stripQuotes(process.env.DB_USER);

console.log('Database config:', {
  host: dbHost,
  port: dbPort,
  database: dbName,
  user: dbUser,
  password: dbPassword ? '***hidden***' : 'NOT SET'
});

const app = express();
app.use(cors());
app.use(express.json());
const server = http.createServer(app);

// Serve static files from the React app build directory
app.use(express.static(path.join(__dirname, 'frontend/build')));

//const pool = new Pool({
//  host: process.env.DB_HOST,
//  port: process.env.DB_PORT,
//  database: process.env.DB_NAME,
//  user: process.env.DB_USER,
//  password: process.env.DB_PASSWORD,
//});

// Build connection string with encoded password
const password = encodeURIComponent(dbPassword);
const connectionString = `postgresql://${dbUser}:${password}@${dbHost}:${dbPort}/${dbName}`;

console.log('Attempting connection to database...');

const pool = new Pool({
  connectionString: connectionString,
  // Cap how long any dashboard query waits on a lock (e.g. table DDL elsewhere)
  // so read paths like the offers snapshot fail fast instead of hanging.
  // Does not limit query execution time, only lock acquisition.
  options: '-c lock_timeout=5s',
});

const wsServer = new WebSocketServer({ server, path: '/ws/offers' });
const wsClients = new Set();

const RECENT_OFFERS_DEFAULT_LIMIT = 100;
const RECENT_OFFERS_MAX_LIMIT = 100;
const AUDIT_DEFAULT_LIMIT = 50;
const AUDIT_MAX_LIMIT = 200;

const parseLimit = (value, defaultValue, maxValue) => {
  const parsed = Number.parseInt(value, 10);
  if (Number.isNaN(parsed) || parsed <= 0) {
    return defaultValue;
  }
  return Math.min(parsed, maxValue);
};

const parseOffset = (value) => {
  const parsed = Number.parseInt(value, 10);
  if (Number.isNaN(parsed) || parsed < 0) {
    return 0;
  }
  return parsed;
};

// Strict YYYY-MM-DD validation. Used for the optional date-range filter on the
// analytics endpoint. Values are validated here so they can be safely inlined
// into SQL (consistent with how dateGrouping/dateFormat are handled).
const DATE_RE = /^\d{4}-\d{2}-\d{2}$/;
const isValidDateStr = (value) => {
  if (typeof value !== 'string' || !DATE_RE.test(value)) return false;
  const d = new Date(`${value}T00:00:00Z`);
  return !Number.isNaN(d.getTime()) && d.toISOString().slice(0, 10) === value;
};

const fetchRecentOffers = async (limit = RECENT_OFFERS_DEFAULT_LIMIT, offset = 0) => {
  const query = `
    SELECT
      id,
      status,
      amount_sats,
      fiat_amount,
      fiat_currency,
      category,
      premium_percent,
      client_version,
      taker_fees,
      maker_fees,
      taker_invoice_fees,
      created_at,
      updated_at,
      reserved_at,
      maker_confirmed_at,
      settled_at,
      taker_charged_at,
      dispute_escalation_reason,
      taker_paid_at
    FROM offers
    ORDER BY created_at DESC
    LIMIT $1
    OFFSET $2
  `;

  const result = await pool.query(query, [limit, offset]);
  return result.rows;
};

const fetchOfferById = async (offerId) => {
  const query = `
    SELECT
      id,
      status,
      amount_sats,
      fiat_amount,
      fiat_currency,
      category,
      premium_percent,
      client_version,
      taker_fees,
      maker_fees,
      taker_invoice_fees,
      created_at,
      updated_at,
      reserved_at,
      maker_confirmed_at,
      settled_at,
      taker_charged_at,
      dispute_escalation_reason,
      taker_paid_at
    FROM offers
    WHERE id = $1
    LIMIT 1
  `;

  const result = await pool.query(query, [offerId]);
  return result.rows[0] || null;
};

const fetchAuditByOfferId = async (offerId, limit = AUDIT_DEFAULT_LIMIT) => {
  const query = `
    SELECT
      id,
      offer_id,
      action,
      level,
      logger_name,
      message,
      error,
      stack_trace,
      metadata,
      created_at
    FROM log_audit
    WHERE offer_id = $1
    ORDER BY created_at DESC, id DESC
    LIMIT $2
  `;

  const result = await pool.query(query, [offerId, limit]);
  return result.rows;
};

const fetchAuditById = async (auditId) => {
  const query = `
    SELECT
      id,
      offer_id,
      action,
      level,
      logger_name,
      message,
      error,
      stack_trace,
      metadata,
      created_at
    FROM log_audit
    WHERE id = $1
    LIMIT 1
  `;

  const result = await pool.query(query, [auditId]);
  return result.rows[0] || null;
};

const sendToClient = (client, payload) => {
  if (client.readyState === WebSocket.OPEN) {
    client.send(JSON.stringify(payload));
  }
};

const broadcast = (payload) => {
  for (const client of wsClients) {
    sendToClient(client, payload);
  }
};

const sendRecentOffersSnapshot = async (client) => {
  const offers = await fetchRecentOffers(RECENT_OFFERS_DEFAULT_LIMIT);
  sendToClient(client, {
    type: 'offers_snapshot',
    offers
  });
};

// CREATE OR REPLACE FUNCTION only locks the function, not the table, so it is
// always safe to run on every boot.
const TRIGGER_FUNCTIONS = `
  CREATE OR REPLACE FUNCTION notify_offers_change()
  RETURNS trigger
  LANGUAGE plpgsql
  AS $$
  DECLARE
    offer_id_value text;
  BEGIN
    offer_id_value := COALESCE(NEW.id::text, OLD.id::text);
    PERFORM pg_notify(
      'offers_changes',
      json_build_object(
        'operation', TG_OP,
        'offer_id', offer_id_value
      )::text
    );

    IF TG_OP = 'DELETE' THEN
      RETURN OLD;
    END IF;

    RETURN NEW;
  END;
  $$;

  CREATE OR REPLACE FUNCTION notify_log_audit_change()
  RETURNS trigger
  LANGUAGE plpgsql
  AS $$
  DECLARE
    offer_id_value text;
    audit_id_value bigint;
  BEGIN
    offer_id_value := COALESCE(NEW.offer_id, OLD.offer_id);
    audit_id_value := COALESCE(NEW.id, OLD.id);

    PERFORM pg_notify(
      'log_audit_changes',
      json_build_object(
        'operation', TG_OP,
        'offer_id', offer_id_value,
        'audit_id', audit_id_value
      )::text
    );

    IF TG_OP = 'DELETE' THEN
      RETURN OLD;
    END IF;

    RETURN NEW;
  END;
  $$;
`;

// Create a trigger only if it's missing. CREATE/DROP TRIGGER needs an
// ACCESS EXCLUSIVE lock on the table, which would otherwise queue behind (and
// block reads behind) the live coordinator's writes. Since the trigger
// definition is stable, skip the work entirely when it already exists, and cap
// the lock wait so a busy table never stalls startup for minutes.
const ensureTrigger = async (table, triggerName, createSql) => {
  const existing = await pool.query(
    `SELECT 1
       FROM pg_trigger t
       JOIN pg_class c ON c.oid = t.tgrelid
      WHERE c.relname = $1 AND t.tgname = $2 AND NOT t.tgisinternal`,
    [table, triggerName]
  );
  if (existing.rowCount > 0) {
    return;
  }

  const client = await pool.connect();
  try {
    await client.query("SET lock_timeout = '4s'");
    await client.query(createSql);
    console.log(`Created trigger ${triggerName} on ${table}`);
  } catch (error) {
    // 55P03 = lock_not_available. Reads still work; notifications resume on a
    // future boot that wins the lock during a write gap.
    console.warn(
      `Skipped creating trigger ${triggerName} on ${table}: ${error.message}`
    );
  } finally {
    client.release();
  }
};

const setupRealtimeTriggers = async () => {
  await pool.query(TRIGGER_FUNCTIONS);

  await ensureTrigger(
    'offers',
    'offers_changes_trigger',
    `CREATE TRIGGER offers_changes_trigger
       AFTER INSERT OR UPDATE OR DELETE ON offers
       FOR EACH ROW
       EXECUTE FUNCTION notify_offers_change()`
  );

  await ensureTrigger(
    'log_audit',
    'log_audit_changes_trigger',
    `CREATE TRIGGER log_audit_changes_trigger
       AFTER INSERT OR UPDATE OR DELETE ON log_audit
       FOR EACH ROW
       EXECUTE FUNCTION notify_log_audit_change()`
  );
};

const startRealtimeListener = async () => {
  try {
    await setupRealtimeTriggers();

    const listenerClient = new Client({
      connectionString: connectionString
    });

    await listenerClient.connect();
    await listenerClient.query('LISTEN offers_changes');
    await listenerClient.query('LISTEN log_audit_changes');

    listenerClient.on('notification', async (message) => {
      if (!message.payload) {
        return;
      }

      try {
        const payload = JSON.parse(message.payload);

        if (message.channel === 'offers_changes') {
          if (!payload.offer_id) {
            return;
          }

          const offer = await fetchOfferById(payload.offer_id);

          if (offer) {
            broadcast({
              type: 'offer_changed',
              offer,
              operation: payload.operation
            });
          } else {
            broadcast({
              type: 'offer_removed',
              offerId: payload.offer_id,
              operation: payload.operation
            });
          }
        }

        if (message.channel === 'log_audit_changes') {
          if (!payload.offer_id) {
            return;
          }

          let auditEntry = null;
          if (payload.audit_id) {
            auditEntry = await fetchAuditById(payload.audit_id);
          }

          if (!auditEntry && payload.operation !== 'DELETE') {
            const latest = await fetchAuditByOfferId(payload.offer_id, 1);
            auditEntry = latest[0] || null;
          }

          broadcast({
            type: 'audit_changed',
            offerId: payload.offer_id,
            operation: payload.operation,
            audit: auditEntry
          });
        }
      } catch (error) {
        console.error('Failed to process realtime notification:', error);
      }
    });

    listenerClient.on('error', (error) => {
      console.error('PostgreSQL LISTEN client error:', error);
    });

    console.log('Realtime listener connected (LISTEN offers_changes, log_audit_changes)');
  } catch (error) {
    console.error('Failed to start realtime listener:', error);
  }
};

wsServer.on('connection', async (socket) => {
  wsClients.add(socket);

  sendToClient(socket, {
    type: 'connection',
    status: 'connected'
  });

  try {
    await sendRecentOffersSnapshot(socket);
  } catch (error) {
    console.error('Failed to send offers snapshot:', error);
    sendToClient(socket, {
      type: 'error',
      message: 'Failed to fetch latest offers snapshot'
    });
  }

  socket.on('message', async (raw) => {
    try {
      const parsed = JSON.parse(raw.toString());
      if (parsed.type === 'refresh_offers') {
        await sendRecentOffersSnapshot(socket);
      }
    } catch (error) {
      console.error('Invalid websocket message:', error);
    }
  });

  socket.on('close', () => {
    wsClients.delete(socket);
  });

  socket.on('error', (error) => {
    console.error('WebSocket client error:', error);
  });
});
//
//const pool = new Pool({
//  connectionString: `postgresql://${process.env.DB_USER}:${encodeURIComponent(process.env.DB_PASSWORD)}@${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`
//});


app.get('/api/offers/recent', async (req, res) => {
  try {
    const limit = parseLimit(req.query.limit, RECENT_OFFERS_DEFAULT_LIMIT, RECENT_OFFERS_MAX_LIMIT);
    const offset = parseOffset(req.query.offset);
    const rows = await fetchRecentOffers(limit, offset);
    res.json({ rows, limit, offset, hasMore: rows.length === limit });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/offers/:offerId/audit', async (req, res) => {
  try {
    const { offerId } = req.params;
    const limit = parseLimit(req.query.limit, AUDIT_DEFAULT_LIMIT, AUDIT_MAX_LIMIT);
    const rows = await fetchAuditByOfferId(offerId, limit);
    res.json({ rows });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: error.message });
  }
});


app.post('/api/offers-data', async (req, res) => {
  try {
    const { groupBy, page = 0, startDate = null, endDate = null } = req.body;

    // Validate groupBy parameter
    const validGroupings = ['daily', 'weekly', 'monthly'];
    if (!groupBy || !validGroupings.includes(groupBy)) {
      return res.status(400).json({ error: 'Invalid groupBy parameter. Must be one of: daily, weekly, monthly' });
    }
    if (!Number.isInteger(page) || page < 0) {
      return res.status(400).json({ error: 'Invalid page parameter. Must be a non-negative integer' });
    }

    // Optional date-range filter (inclusive on both ends). Both bounds required
    // together. When active, paging is disabled and every chart/total reflects
    // only offers created within the range.
    let dateFilter = null;
    const hasRange = startDate != null || endDate != null;
    if (hasRange) {
      if (!isValidDateStr(startDate) || !isValidDateStr(endDate)) {
        return res.status(400).json({ error: 'Invalid startDate/endDate. Use YYYY-MM-DD and provide both.' });
      }
      if (startDate > endDate) {
        return res.status(400).json({ error: 'startDate must be on or before endDate.' });
      }
      dateFilter = `created_at >= '${startDate}'::date AND created_at < ('${endDate}'::date + INTERVAL '1 day')`;
    }
    const whereClause = dateFilter ? `WHERE ${dateFilter}` : '';
    const andClause = dateFilter ? `AND ${dateFilter}` : '';
    const usePaging = !dateFilter;

    // Build SQL query based on grouping - secure, server-side only
    let dateGrouping;
    let dateFormat;
    let pageSize;

    switch(groupBy) {
      case 'daily':
        dateGrouping = "DATE(created_at)";
        dateFormat = "YYYY-MM-DD";
        pageSize = 30;
        break;
      case 'weekly':
        dateGrouping = "DATE_TRUNC('week', created_at)";
        dateFormat = "YYYY-MM-DD";
        pageSize = 12;
        break;
      case 'monthly':
        dateGrouping = "DATE_TRUNC('month', created_at)";
        dateFormat = "YYYY-MM";
        pageSize = 12;
        break;
    }
    
    const offset = page * pageSize;
    const pagingClause = usePaging ? 'OFFSET $1 LIMIT $2' : '';
    const pagingParams = usePaging ? [offset, pageSize] : [];

    const groupedQuery = `
      WITH grouped_periods AS (
        SELECT
          ${dateGrouping} AS period_start,
          ROUND(
            100 - (
              CAST(COUNT(*) FILTER (WHERE status IN ('expired', 'cancelled')) AS NUMERIC) /
              NULLIF(CAST(COUNT(*) FILTER (WHERE status IN ('expired', 'cancelled', 'takerPaid')) AS NUMERIC), 0)
            ) * 100,
            2
          ) AS success_percentage,
          COUNT(*) FILTER (WHERE status IN ('expired', 'cancelled')) AS failed,
          COUNT(*) FILTER (WHERE status = 'takerPaid') AS success,
          COALESCE(SUM(maker_fees + taker_fees - taker_invoice_fees) FILTER (WHERE status = 'takerPaid'), 0) AS profit,
          COALESCE(SUM(fiat_amount) FILTER (WHERE status = 'takerPaid'), 0) AS volume,
          COALESCE(SUM(amount_sats) FILTER (WHERE status = 'takerPaid'), 0) AS volume_sats,
          COUNT(*) FILTER (WHERE status = 'takerPaid') AS success_count,
          EXTRACT(EPOCH FROM AVG(reserved_at - created_at) FILTER (WHERE status = 'takerPaid')) AS avg_reserved_seconds,
          EXTRACT(EPOCH FROM AVG(maker_confirmed_at - created_at) FILTER (WHERE status = 'takerPaid')) AS avg_total_seconds,
          ROUND(COALESCE(AVG(taker_invoice_fees) FILTER (WHERE status = 'takerPaid'), 0), 2) AS avg_taker_invoice_fees,
          ROUND(
            COALESCE(
              AVG(taker_invoice_fees * 100.0 / NULLIF(amount_sats - taker_fees, 0)) FILTER (WHERE status = 'takerPaid'),
              0
            ) * 100,
            2
          ) AS taker_fees_percentage
        FROM offers
        ${whereClause}
        GROUP BY ${dateGrouping}
      ),
      paged_periods AS (
        SELECT *
        FROM grouped_periods
        ORDER BY period_start DESC
        ${pagingClause}
      )
      SELECT
        TO_CHAR(period_start, '${dateFormat}') AS date,
        success_percentage,
        failed,
        success,
        profit,
        volume,
        volume_sats,
        success_count,
        avg_reserved_seconds,
        avg_total_seconds,
        avg_taker_invoice_fees,
        taker_fees_percentage
      FROM paged_periods
      ORDER BY period_start ASC
    `;

    const groupedCountQuery = `
      SELECT COUNT(*)::INT AS total_periods
      FROM (
        SELECT ${dateGrouping}
        FROM offers
        ${whereClause}
        GROUP BY ${dateGrouping}
      ) grouped_periods
    `;

    // Overall totals - same regardless of grouping
    const totalsQuery = `
      SELECT
        COUNT(*) FILTER (WHERE status IN ('expired', 'cancelled')) AS total_failed,
        COUNT(*) FILTER (WHERE status = 'takerPaid') AS total_success,
        COALESCE(SUM(maker_fees + taker_fees - taker_invoice_fees) FILTER (WHERE status = 'takerPaid'), 0) AS total_profit,
        COALESCE(SUM(fiat_amount) FILTER (WHERE status = 'takerPaid'), 0) AS total_volume,
        COALESCE(SUM(amount_sats) FILTER (WHERE status = 'takerPaid'), 0) AS total_volume_sats,
        ROUND(
          100 - (
            CAST(COUNT(*) FILTER (WHERE status IN ('expired', 'cancelled')) AS NUMERIC) /
            NULLIF(CAST(COUNT(*) FILTER (WHERE status IN ('expired', 'cancelled', 'takerPaid')) AS NUMERIC), 0)
          ) * 100,
          2
        ) AS overall_success_percentage,
        EXTRACT(EPOCH FROM AVG(reserved_at - created_at) FILTER (WHERE status = 'takerPaid')) AS overall_avg_reserved_seconds,
        EXTRACT(EPOCH FROM AVG(maker_confirmed_at - created_at) FILTER (WHERE status = 'takerPaid')) AS overall_avg_total_seconds,
        ROUND(COALESCE(AVG(taker_invoice_fees) FILTER (WHERE status = 'takerPaid'), 0), 2) AS overall_avg_taker_invoice_fees,
        ROUND(
          COALESCE(
            AVG(taker_invoice_fees * 100.0 / NULLIF(amount_sats - taker_fees, 0)) FILTER (WHERE status = 'takerPaid'),
            0
          ) * 100,
          2
        ) AS overall_taker_fees_percentage
      FROM offers
      ${whereClause}
    `;

    // Successful offers by weekday (Mon-Sun), independent of selected period
    const weekdaySuccessQuery = `
      WITH weekdays AS (
        SELECT
          day_num,
          day_name
        FROM (VALUES
          (1, 'Mon'),
          (2, 'Tue'),
          (3, 'Wed'),
          (4, 'Thu'),
          (5, 'Fri'),
          (6, 'Sat'),
          (7, 'Sun')
        ) AS w(day_num, day_name)
      ),
      date_bounds AS (
        SELECT
          DATE(MIN(created_at)) AS min_date,
          DATE(MAX(created_at)) AS max_date
        FROM offers
        ${whereClause}
      ),
      calendar_dates AS (
        SELECT
          generate_series(min_date, max_date, INTERVAL '1 day')::DATE AS offer_date
        FROM date_bounds
        WHERE min_date IS NOT NULL
      ),
      offers_by_date AS (
        SELECT
          DATE(created_at) AS offer_date,
          COUNT(*) FILTER (WHERE status = 'takerPaid') AS success_count,
          COUNT(*) AS offer_count
        FROM offers
        ${whereClause}
        GROUP BY DATE(created_at)
      ),
      weekday_daily AS (
        SELECT
          EXTRACT(ISODOW FROM c.offer_date)::INT AS day_num,
          COALESCE(o.success_count, 0) AS success_count,
          COALESCE(o.offer_count, 0) AS offer_count
        FROM calendar_dates c
        LEFT JOIN offers_by_date o ON o.offer_date = c.offer_date
      ),
      weekday_aggregates AS (
        SELECT
          day_num,
          SUM(success_count) AS success_count,
          ROUND(AVG(offer_count)::NUMERIC, 2) AS avg_offer_count
        FROM weekday_daily
        GROUP BY day_num
      )
      SELECT
        w.day_name AS weekday,
        COALESCE(a.success_count, 0) AS success_count,
        COALESCE(a.avg_offer_count, 0) AS avg_offer_count
      FROM weekdays w
      LEFT JOIN weekday_aggregates a ON a.day_num = w.day_num
      ORDER BY w.day_num
    `;

    // Successful offer volume by weekday (Mon-Sun), independent of selected period
    const weekdayVolumeQuery = `
      WITH weekdays AS (
        SELECT
          day_num,
          day_name
        FROM (VALUES
          (1, 'Mon'),
          (2, 'Tue'),
          (3, 'Wed'),
          (4, 'Thu'),
          (5, 'Fri'),
          (6, 'Sat'),
          (7, 'Sun')
        ) AS w(day_num, day_name)
      ),
      date_bounds AS (
        SELECT
          DATE(MIN(created_at)) AS min_date,
          DATE(MAX(created_at)) AS max_date
        FROM offers
        ${whereClause}
      ),
      calendar_dates AS (
        SELECT
          generate_series(min_date, max_date, INTERVAL '1 day')::DATE AS offer_date
        FROM date_bounds
        WHERE min_date IS NOT NULL
      ),
      volume_by_date AS (
        SELECT
          DATE(created_at) AS offer_date,
          COALESCE(SUM(fiat_amount) FILTER (WHERE status = 'takerPaid'), 0) AS volume_fiat
        FROM offers
        ${whereClause}
        GROUP BY DATE(created_at)
      ),
      weekday_daily AS (
        SELECT
          EXTRACT(ISODOW FROM c.offer_date)::INT AS day_num,
          COALESCE(v.volume_fiat, 0) AS volume_fiat
        FROM calendar_dates c
        LEFT JOIN volume_by_date v ON v.offer_date = c.offer_date
      ),
      weekday_aggregates AS (
        SELECT
          day_num,
          ROUND(SUM(volume_fiat)::NUMERIC, 2) AS total_volume_fiat,
          ROUND(AVG(volume_fiat)::NUMERIC, 2) AS avg_volume_fiat
        FROM weekday_daily
        GROUP BY day_num
      )
      SELECT
        w.day_name AS weekday,
        COALESCE(a.total_volume_fiat, 0) AS total_volume_fiat,
        COALESCE(a.avg_volume_fiat, 0) AS avg_volume_fiat
      FROM weekdays w
      LEFT JOIN weekday_aggregates a ON a.day_num = w.day_num
      ORDER BY w.day_num
    `;

    // Category distribution per period, restricted to the same paged window
    // of periods so the stacked bars line up with the other period charts.
    const categoryDistributionQuery = `
      WITH paged_periods AS (
        SELECT DISTINCT ${dateGrouping} AS period_start
        FROM offers
        ${whereClause}
        ORDER BY period_start DESC
        ${pagingClause}
      )
      SELECT
        TO_CHAR(${dateGrouping}, '${dateFormat}') AS date,
        COALESCE(NULLIF(TRIM(category), ''), 'unknown') AS category,
        COUNT(*) FILTER (WHERE status = 'takerPaid')::INT AS count,
        COALESCE(SUM(fiat_amount) FILTER (WHERE status = 'takerPaid'), 0) AS volume
      FROM offers
      WHERE ${dateGrouping} IN (SELECT period_start FROM paged_periods)
      ${andClause}
      GROUP BY ${dateGrouping}, COALESCE(NULLIF(TRIM(category), ''), 'unknown')
      ORDER BY ${dateGrouping} ASC
    `;

    // Client-version distribution per period (one count per client build that
    // created offers), restricted to the same paged window of periods so the
    // lines line up with the other period charts.
    const clientVersionDistributionQuery = `
      WITH paged_periods AS (
        SELECT DISTINCT ${dateGrouping} AS period_start
        FROM offers
        ${whereClause}
        ORDER BY period_start DESC
        ${pagingClause}
      )
      SELECT
        TO_CHAR(${dateGrouping}, '${dateFormat}') AS date,
        COALESCE(NULLIF(TRIM(client_version), ''), 'unknown') AS client,
        COUNT(*)::INT AS count
      FROM offers
      WHERE ${dateGrouping} IN (SELECT period_start FROM paged_periods)
      ${andClause}
      GROUP BY ${dateGrouping}, COALESCE(NULLIF(TRIM(client_version), ''), 'unknown')
      ORDER BY ${dateGrouping} ASC
    `;

    const [groupedResult, groupedCountResult, totalsResult, weekdaySuccessResult, weekdayVolumeResult, categoryDistributionResult, clientVersionDistributionResult] = await Promise.all([
      pool.query(groupedQuery, pagingParams),
      pool.query(groupedCountQuery),
      pool.query(totalsQuery),
      pool.query(weekdaySuccessQuery),
      pool.query(weekdayVolumeQuery),
      pool.query(categoryDistributionQuery, pagingParams),
      pool.query(clientVersionDistributionQuery, pagingParams)
    ]);

    const totalPeriods = groupedCountResult.rows[0]?.total_periods || 0;

    res.json({
      rows: groupedResult.rows,
      totals: totalsResult.rows[0],
      weekdaySuccess: weekdaySuccessResult.rows,
      weekdayVolume: weekdayVolumeResult.rows,
      categoryDistribution: categoryDistributionResult.rows,
      clientVersionDistribution: clientVersionDistributionResult.rows,
      pagination: {
        page: usePaging ? page : 0,
        pageSize,
        totalPeriods,
        // Paging is disabled while a custom date range is active.
        hasOlder: usePaging ? offset + pageSize < totalPeriods : false,
        hasNewer: usePaging ? page > 0 : false,
        dateRange: dateFilter ? { startDate, endDate } : null,
      }
    });
  } catch (error) {
    console.error('Database error:', error);
    res.status(500).json({ error: error.message });
  }
});

// Serve React app for all other routes (must be after API routes)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'frontend/build', 'index.html'));
});

const PORT = process.env.PORT || 3001;
server.listen(PORT, '0.0.0.0', async () => {
  console.log(`Server running on http://0.0.0.0:${PORT}`);
  console.log(`- API endpoints: /api/*`);
  console.log(`- WebSocket: ws://0.0.0.0:${PORT}/ws/offers`);
  console.log(`- Frontend served from: ${path.join(__dirname, 'frontend/build')}`);
  await startRealtimeListener();
});
