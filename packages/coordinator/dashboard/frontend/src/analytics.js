const numberValue = (value) => {
  const parsed = Number.parseFloat(value || 0);
  return Number.isFinite(parsed) ? parsed : 0;
};

const weightedValue = (items, field, weightField) => {
  const totalWeight = items.reduce((sum, item) => sum + numberValue(item[weightField]), 0);
  if (!totalWeight) return 0;
  return items.reduce(
    (sum, item) => sum + numberValue(item[field]) * numberValue(item[weightField]),
    0
  ) / totalWeight;
};

const conversionFactor = (sourceCurrency, targetCurrency, rates) => {
  if (sourceCurrency === targetCurrency) return 1;
  const sourceRate = rates[sourceCurrency];
  const targetRate = rates[targetCurrency];
  if (!sourceRate || !targetRate) {
    throw new Error(`Missing BTC exchange rate for ${sourceCurrency} or ${targetCurrency}`);
  }
  return targetRate / sourceRate;
};

const mergePeriodRows = (entries) => {
  const byDate = new Map();

  entries.forEach(({ result, factor }) => {
    (result.rows || []).forEach((row) => {
      const current = byDate.get(row.date) || {
        date: row.date,
        success: 0,
        failed: 0,
        profit: 0,
        volume: 0,
        volume_sats: 0,
        success_count: 0,
        _rows: [],
      };
      current.success += numberValue(row.success);
      current.failed += numberValue(row.failed);
      current.profit += numberValue(row.profit);
      current.volume += numberValue(row.volume) * factor;
      current.volume_sats += numberValue(row.volume_sats);
      current.success_count += numberValue(row.success_count);
      current._rows.push(row);
      byDate.set(row.date, current);
    });
  });

  return Array.from(byDate.values())
    .sort((a, b) => a.date.localeCompare(b.date))
    .map((row) => {
      const decided = row.success + row.failed;
      const merged = {
        ...row,
        success_percentage: decided ? (row.success / decided) * 100 : 0,
        avg_reserved_seconds: weightedValue(row._rows, 'avg_reserved_seconds', 'success_count'),
        avg_total_seconds: weightedValue(row._rows, 'avg_total_seconds', 'success_count'),
        avg_taker_invoice_fees: weightedValue(row._rows, 'avg_taker_invoice_fees', 'success_count'),
        taker_fees_percentage: weightedValue(row._rows, 'taker_fees_percentage', 'success_count'),
      };
      delete merged._rows;
      return merged;
    });
};

const mergeTotals = (entries) => {
  const totals = entries
    .filter(({ result }) => result.totals)
    .map(({ result, factor }) => ({ ...result.totals, _factor: factor }));
  if (!totals.length) return null;

  const totalSuccess = totals.reduce((sum, item) => sum + numberValue(item.total_success), 0);
  const totalFailed = totals.reduce((sum, item) => sum + numberValue(item.total_failed), 0);
  const decided = totalSuccess + totalFailed;

  return {
    total_success: totalSuccess,
    total_failed: totalFailed,
    total_profit: totals.reduce((sum, item) => sum + numberValue(item.total_profit), 0),
    total_volume: totals.reduce(
      (sum, item) => sum + numberValue(item.total_volume) * item._factor,
      0
    ),
    total_volume_sats: totals.reduce((sum, item) => sum + numberValue(item.total_volume_sats), 0),
    overall_success_percentage: decided ? (totalSuccess / decided) * 100 : 0,
    overall_avg_reserved_seconds: weightedValue(totals, 'overall_avg_reserved_seconds', 'total_success'),
    overall_avg_total_seconds: weightedValue(totals, 'overall_avg_total_seconds', 'total_success'),
    overall_avg_taker_invoice_fees: weightedValue(totals, 'overall_avg_taker_invoice_fees', 'total_success'),
    overall_taker_fees_percentage: weightedValue(totals, 'overall_taker_fees_percentage', 'total_success'),
  };
};

const mergeWeekdays = (entries, fieldDefinitions) => {
  const byWeekday = new Map();
  entries.forEach(({ result, factor }) => {
    const rows = fieldDefinitions.source === 'volume'
      ? result.weekdayVolume || []
      : result.weekdaySuccess || [];
    rows.forEach((row) => {
      const current = byWeekday.get(row.weekday) || { weekday: row.weekday };
      fieldDefinitions.fields.forEach(({ name, fiat }) => {
        current[name] = numberValue(current[name]) + numberValue(row[name]) * (fiat ? factor : 1);
      });
      byWeekday.set(row.weekday, current);
    });
  });
  const order = new Map(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day, index) => [day, index]));
  return Array.from(byWeekday.values()).sort(
    (a, b) => (order.get(a.weekday) ?? 99) - (order.get(b.weekday) ?? 99)
  );
};

const mergeDistribution = (entries, sourceField, keys, fiatFields = []) => {
  const merged = new Map();
  entries.forEach(({ result, factor }) => {
    (result[sourceField] || []).forEach((row) => {
      const id = keys.map((key) => row[key] || 'unknown').join('\u0000');
      const current = merged.get(id) || Object.fromEntries(keys.map((key) => [key, row[key] || 'unknown']));
      Object.entries(row).forEach(([field, value]) => {
        if (keys.includes(field)) return;
        current[field] = numberValue(current[field]) + numberValue(value) * (fiatFields.includes(field) ? factor : 1);
      });
      merged.set(id, current);
    });
  });
  return Array.from(merged.values()).sort((a, b) => keys
    .map((key) => String(a[key]).localeCompare(String(b[key])))
    .find((comparison) => comparison !== 0) || 0);
};

export const aggregateAnalyticsResults = (analyticsResults, targetCurrency, rates = {}) => {
  const entries = analyticsResults.map((result) => {
    const sourceCurrency = String(result.currency || 'PLN').toUpperCase();
    return {
      result,
      factor: conversionFactor(sourceCurrency, targetCurrency, rates),
    };
  });

  const paginations = analyticsResults.map((result) => result.pagination).filter(Boolean);

  return {
    currency: targetCurrency,
    rows: mergePeriodRows(entries),
    totals: mergeTotals(entries),
    weekdaySuccess: mergeWeekdays(entries, {
      source: 'success',
      fields: [{ name: 'success_count' }, { name: 'avg_offer_count' }],
    }),
    weekdayVolume: mergeWeekdays(entries, {
      source: 'volume',
      fields: [{ name: 'total_volume_fiat', fiat: true }, { name: 'avg_volume_fiat', fiat: true }],
    }),
    categoryDistribution: mergeDistribution(
      entries,
      'categoryDistribution',
      ['date', 'category'],
      ['volume']
    ),
    clientVersionDistribution: mergeDistribution(
      entries,
      'clientVersionDistribution',
      ['date', 'client']
    ),
    pagination: paginations.length ? {
      page: paginations[0].page || 0,
      pageSize: Math.max(...paginations.map((item) => numberValue(item.pageSize))),
      totalPeriods: Math.max(...paginations.map((item) => numberValue(item.totalPeriods))),
      hasOlder: paginations.some((item) => item.hasOlder),
      hasNewer: paginations.some((item) => item.hasNewer),
      dateRange: paginations[0].dateRange || null,
    } : null,
  };
};
