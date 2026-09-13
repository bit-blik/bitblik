import React, { useState, useEffect, useRef, useCallback } from 'react';
import {
  List,
  RefreshCw,
  Wifi,
  WifiOff,
  ChevronRight,
  X,
  AlertTriangle,
  Info,
  CheckCircle,
  XCircle,
  GitBranch,
  ArrowDown,
  Clock3,
  Bot,
  User,
  Globe,
  Workflow,
} from 'lucide-react';
import { Link } from 'react-router-dom';
import { buildCoordinatorApiUrl, buildCoordinatorWebSocketUrl } from '../coordinators';

// Max offers returned per page by the dashboard API. Older offers load
// incrementally as the operator scrolls past the end of the list.
const OFFERS_PAGE_SIZE = 100;

// Category color scheme: shop -> red, atm -> green (emerald), online -> blue.
// Matches the stacked-bar colors in App.js (CATEGORY_CHART_COLORS).
const CATEGORY_COLORS = {
  shop: 'bg-red-100 text-red-800 border-red-300',
  atm: 'bg-emerald-100 text-emerald-800 border-emerald-300',
  online: 'bg-blue-100 text-blue-800 border-blue-300',
};

const CATEGORY_INLINE_STYLES = {};

const STATUS_COLORS = {
  pending: 'bg-yellow-100 text-yellow-800 border-yellow-300',
  funded: 'bg-amber-100 text-amber-800 border-amber-300',
  reserved: 'bg-blue-100 text-blue-800 border-blue-300',
  blikReceived: 'bg-indigo-100 text-indigo-800 border-indigo-300',
  blikSentToMaker: 'bg-sky-100 text-sky-800 border-sky-300',
  makerConfirmed: 'bg-purple-100 text-purple-800 border-purple-300',
  settled: 'bg-teal-100 text-teal-800 border-teal-300',
  payingTaker: 'bg-cyan-100 text-cyan-800 border-cyan-300',
  takerPaid: 'bg-green-100 text-green-800 border-green-300',
  takerPaymentFailed: 'bg-rose-100 text-rose-800 border-rose-300',
  dispute: 'bg-rose-100 text-rose-800 border-rose-300',
  conflict: 'bg-orange-100 text-orange-800 border-orange-300',
  invalidBlik: 'bg-orange-100 text-orange-800 border-orange-300',
  expiredBlik: 'bg-slate-100 text-slate-800 border-slate-300',
  expiredSentBlik: 'bg-slate-100 text-slate-800 border-slate-300',
  twint_charged: 'bg-cyan-100 text-cyan-800 border-cyan-300',
  expired_twint: 'bg-slate-100 text-slate-800 border-slate-300',
  expired: 'bg-gray-100 text-gray-800 border-gray-300',
  cancelled: 'bg-red-100 text-red-800 border-red-300',
  failed: 'bg-red-100 text-red-800 border-red-300',
};

// Fallback status set (all known statuses) used only when a coordinator has no
// flow definition — normally the pill list comes from the coordinator's flow
// states, so systems the coordinator can't reach (e.g. BLIK states on a TWINT
// coordinator) are never offered.
const KNOWN_STATUSES = Object.keys(STATUS_COLORS);

const LEVEL_ICONS = {
  error: <XCircle size={14} className="text-red-500" />,
  warn: <AlertTriangle size={14} className="text-amber-500" />,
  info: <Info size={14} className="text-blue-500" />,
  debug: <CheckCircle size={14} className="text-gray-400" />,
};

const DISPUTE_REASON_LABELS = {
  autoExpiredSentBlikTimeout: 'Auto dispute after expiredSentBlik timeout',
  autoInvalidBlikTimeout: 'Auto dispute after invalidBlik timeout',
  autoConflictTimeout: 'Auto dispute after conflict timeout',
  makerOpenedDispute: 'Opened manually by maker',
  unknown: 'Unknown dispute reason',
};

const TERMINAL_STATE_STYLES = {
  takerPaid: 'border-emerald-300 bg-emerald-50 text-emerald-800',
  expired: 'border-slate-300 bg-slate-100 text-slate-700',
  cancelled: 'border-slate-300 bg-slate-100 text-slate-700',
  dispute: 'border-rose-300 bg-rose-50 text-rose-800',
  takerPaymentFailed: 'border-rose-300 bg-rose-50 text-rose-800',
};

const TRIGGER_STYLES = {
  user_action: {
    badge: 'bg-blue-100 text-blue-700 border-blue-200',
    card: 'border-blue-200 bg-blue-50/70',
    icon: <User size={14} className="text-blue-600" />,
  },
  timeout: {
    badge: 'bg-amber-100 text-amber-700 border-amber-200',
    card: 'border-amber-200 bg-amber-50/70',
    icon: <Clock3 size={14} className="text-amber-600" />,
  },
  auto: {
    badge: 'bg-violet-100 text-violet-700 border-violet-200',
    card: 'border-violet-200 bg-violet-50/70',
    icon: <Bot size={14} className="text-violet-600" />,
  },
  coordinator: {
    badge: 'bg-slate-100 text-slate-700 border-slate-200',
    card: 'border-slate-200 bg-slate-50/80',
    icon: <GitBranch size={14} className="text-slate-600" />,
  },
};

// Display zone — render all timestamps in Budapest regardless of the
// viewer's browser zone. The stored values are UTC instants (timestamptz).
const DISPLAY_TZ = 'Europe/Budapest';

// Day key (YYYY-MM-DD) computed in DISPLAY_TZ so day grouping/labels don't
// drift across midnight when the browser is in a different zone.
const dayKeyInTz = (d) => d.toLocaleDateString('en-CA', { timeZone: DISPLAY_TZ });

const formatDate = (dateString) => {
  if (!dateString) return '-';
  const d = new Date(dateString);
  return d.toLocaleString('pl-PL', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    timeZone: DISPLAY_TZ,
  });
};

const formatDayLabel = (dateString) => {
  if (!dateString) return 'Unknown';
  const d = new Date(dateString);
  const today = new Date();
  const yesterday = new Date(today);
  yesterday.setDate(yesterday.getDate() - 1);
  const sameDay = (a, b) => dayKeyInTz(a) === dayKeyInTz(b);
  if (sameDay(d, today)) return 'Today';
  if (sameDay(d, yesterday)) return 'Yesterday';
  return d.toLocaleDateString('en-GB', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric',
    timeZone: DISPLAY_TZ,
  });
};

const groupOffersByDay = (offers) => {
  const groups = [];
  let currentDayKey = null;
  let currentGroup = null;
  for (const offer of offers) {
    const dateStr = offer.created_at;
    const d = new Date(dateStr);
    const dayKey = dayKeyInTz(d);
    if (dayKey !== currentDayKey) {
      currentDayKey = dayKey;
      currentGroup = { dayLabel: formatDayLabel(dateStr), offers: [] };
      groups.push(currentGroup);
    }
    currentGroup.offers.push(offer);
  }
  return groups;
};

const formatSats = (value) => {
  if (value === null || value === undefined) return '-';
  return new Intl.NumberFormat('en-US').format(value);
};

const formatCurrency = (value, currency = 'PLN') => {
  if (value === null || value === undefined) return '-';
  return new Intl.NumberFormat('pl-PL', {
    style: 'currency',
    currency: currency || 'PLN',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(value);
};

const num = (value) => {
  const parsed = Number.parseFloat(value);
  return Number.isFinite(parsed) ? parsed : 0;
};

const calcTakerFeePct = (taker_invoice_fees, amount_sats) => {
  if (!taker_invoice_fees || !amount_sats || amount_sats === 0) return null;
  return (taker_invoice_fees * 100) / amount_sats;
};

// The API serves BIGINT columns as strings (node-postgres does not narrow them
// to Number), so these must be coerced before any addition — `"368" + "1080"`
// concatenates to 3681080 instead of summing to 1448, and the following
// subtraction then silently turns that into a plausible-looking number.
export const calcProfit = (maker_fees, taker_fees, taker_invoice_fees) => {
  if (maker_fees == null && taker_fees == null) return null;
  return num(maker_fees) + num(taker_fees) - num(taker_invoice_fees);
};

export const calcProfitFiat = (profit_sats, fiat_amount, amount_sats) => {
  if (profit_sats == null || !fiat_amount || !amount_sats || amount_sats === 0) return null;
  return (profit_sats * fiat_amount) / amount_sats;
};

const calcDuration = (from, to) => {
  if (!from || !to) return null;
  const ms = new Date(to) - new Date(from);
  if (ms < 0) return null;
  const totalSecs = Math.floor(ms / 1000);
  const h = Math.floor(totalSecs / 3600);
  const m = Math.floor((totalSecs % 3600) / 60);
  const s = totalSecs % 60;
  if (h > 0) return `${h}h ${m}m`;
  if (m > 0) return `${m}m ${s}s`;
  return `${s}s`;
};

const calcDurationBetweenDates = (from, to) => {
  if (!from || !to) return null;
  return calcDuration(from, to);
};

const formatDisputeReason = (reason) => {
  if (!reason) return '-';
  return DISPUTE_REASON_LABELS[reason] || reason;
};

const shortenPubkey = (value) => {
  if (!value) return '-';
  if (value.startsWith('npub') && value.length > 16) {
    return `${value.slice(0, 8)}...${value.slice(-4)}`;
  }
  if (value.length <= 16) return value;
  return `${value.slice(0, 8)}...${value.slice(-4)}`;
};

const buildPubkeyAvatarUrl = (pubkey) => {
  if (!pubkey) return null;
  return `https://robohash.org/${encodeURIComponent(pubkey)}?set=set4`;
};

const formatRelativeTime = (dateString) => {
  if (!dateString) return '';
  const value = new Date(dateString);
  if (Number.isNaN(value.getTime())) return '';

  const diffMs = value.getTime() - Date.now();
  const diffSecs = Math.round(diffMs / 1000);
  const formatter = new Intl.RelativeTimeFormat('en', { numeric: 'auto' });

  if (Math.abs(diffSecs) < 60) return formatter.format(diffSecs, 'second');
  const diffMins = Math.round(diffSecs / 60);
  if (Math.abs(diffMins) < 60) return formatter.format(diffMins, 'minute');
  const diffHours = Math.round(diffMins / 60);
  if (Math.abs(diffHours) < 24) return formatter.format(diffHours, 'hour');
  const diffDays = Math.round(diffHours / 24);
  return formatter.format(diffDays, 'day');
};

const normalizeMetadataArray = (metadata, key) => {
  const value = metadata?.[key];
  return Array.isArray(value) ? value : [];
};

const getTriggerStyle = (triggerType) => TRIGGER_STYLES[triggerType] || TRIGGER_STYLES.coordinator;
const getTransitionEventLabel = (transition) =>
  transition.event || (transition.trigger_type === 'timeout' ? 'timeout' : 'state transition');

const capitalizeWord = (value) => value ? value.charAt(0).toUpperCase() + value.slice(1) : '';

const parseClientDescriptor = (clientValue) => {
  if (!clientValue || typeof clientValue !== 'string') return null;

  const [clientId, version = ''] = clientValue.split('/');
  if (!clientId) return null;

  let brand = '';
  let platformTokens = [];

  if (clientId.startsWith('app-')) {
    const parts = clientId.slice(4).split('-').filter(Boolean);
    brand = parts.shift() || '';
    platformTokens = parts;
  } else {
    const parts = clientId.split('-').filter(Boolean);
    brand = parts.shift() || '';
    platformTokens = parts;
  }

  const normalizedPlatforms = platformTokens.map((token) => token.toLowerCase());
  const icons = [];
  if (normalizedPlatforms.includes('web')) icons.push('web');
  if (normalizedPlatforms.includes('ios')) icons.push('ios');
  if (normalizedPlatforms.includes('android')) icons.push('android');

  const brandLabel = capitalizeWord(brand) || 'Unknown';
  const hasWeb = normalizedPlatforms.includes('web');
  const hasIos = normalizedPlatforms.includes('ios');
  const hasAndroid = normalizedPlatforms.includes('android');

  let platformLabel = '';
  if (hasWeb && hasIos) platformLabel = 'Web on iOS';
  else if (hasWeb && hasAndroid) platformLabel = 'Web on Android';
  else if (hasWeb) platformLabel = 'Web';
  else if (hasIos) platformLabel = 'iOS';
  else if (hasAndroid) platformLabel = 'Android';
  else if (normalizedPlatforms.length > 0) platformLabel = normalizedPlatforms.map(capitalizeWord).join(' ');

  const fullName = [brandLabel, platformLabel, version ? `v${version}` : ''].filter(Boolean).join(' ');

  return {
    raw: clientValue,
    brand: brandLabel,
    version,
    icons,
    fullName,
  };
};

const AndroidGlyph = ({ size = 14 }) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 24 24"
    fill="#3DDC84"
    aria-label="Android"
    role="img"
  >
    {/* antennae */}
    <path
      d="M8.5 4 L7 1.8 M15.5 4 L17 1.8"
      stroke="#3DDC84"
      strokeWidth="1.2"
      strokeLinecap="round"
    />
    {/* head dome */}
    <path d="M6 9 A6 6 0 0 1 18 9 Z" />
    {/* eyes */}
    <circle cx="9.7" cy="6.4" r="0.85" fill="#fff" />
    <circle cx="14.3" cy="6.4" r="0.85" fill="#fff" />
    {/* body */}
    <rect x="6" y="9.5" width="12" height="9" rx="1.6" />
    {/* arms */}
    <rect x="3.1" y="10" width="2" height="6.6" rx="1" />
    <rect x="18.9" y="10" width="2" height="6.6" rx="1" />
    {/* legs */}
    <rect x="8" y="18" width="2.3" height="4" rx="1" />
    <rect x="13.7" y="18" width="2.3" height="4" rx="1" />
  </svg>
);

const AppleGlyph = ({ size = 14 }) => (
  <svg
    width={size}
    height={size}
    viewBox="0 0 24 24"
    fill="currentColor"
    className="text-slate-700"
    aria-label="iOS"
    role="img"
  >
    <path d="M12.152 6.896c-.948 0-2.415-1.078-3.96-1.04-2.04.027-3.91 1.183-4.961 3.014-2.117 3.675-.546 9.103 1.519 12.09 1.013 1.454 2.208 3.09 3.792 3.039 1.52-.065 2.09-.987 3.935-.987 1.831 0 2.35.987 3.96.948 1.637-.026 2.676-1.48 3.676-2.948 1.156-1.688 1.636-3.325 1.662-3.415-.039-.013-3.182-1.221-3.22-4.857-.026-3.04 2.48-4.494 2.597-4.559-1.429-2.09-3.623-2.324-4.39-2.376-2-.156-3.675 1.09-4.61 1.09zM15.53 3.83c.843-1.012 1.4-2.427 1.245-3.83-1.207.052-2.662.805-3.532 1.818-.78.896-1.454 2.338-1.273 3.714 1.338.104 2.715-.688 3.559-1.701" />
  </svg>
);

const ClientIcons = ({ client, size = 14 }) => {
  const descriptor = parseClientDescriptor(client);
  if (!descriptor || descriptor.icons.length === 0) return null;

  return (
    <span className="inline-flex items-center gap-1 text-slate-500" title={descriptor.fullName}>
      {descriptor.icons.map((icon) => {
        if (icon === 'web') return <Globe key={`${icon}-${descriptor.raw}`} size={size} />;
        if (icon === 'ios') return <AppleGlyph key={`${icon}-${descriptor.raw}`} size={size} />;
        return <AndroidGlyph key={`${icon}-${descriptor.raw}`} size={size} />;
      })}
    </span>
  );
};

const getStateClasses = (state) => {
  if (TERMINAL_STATE_STYLES[state]) {
    return TERMINAL_STATE_STYLES[state];
  }

  const base = STATUS_COLORS[state] || 'bg-gray-100 text-gray-800 border-gray-300';
  return base.replace(/rounded-full/g, '').trim();
};

const renderOfferSummary = (offer) => (
  <div className="px-6 py-3 bg-blue-50 border-b border-blue-100">
    <div className="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-6 gap-4 text-sm">
      <div>
        <span className="text-gray-500">Amount:</span>
        <span className="ml-2 font-medium text-gray-900">
          {formatSats(offer.amount_sats)} sats
        </span>
      </div>
      <div>
        <span className="text-gray-500">Fiat:</span>
        <span className="ml-2 font-medium text-emerald-700">
          {formatCurrency(offer.fiat_amount, offer.fiat_currency)}
        </span>
      </div>
      <div>
        <span className="text-gray-500">Created:</span>
        <span className="ml-2 font-medium text-gray-900">
          {formatDate(offer.created_at)}
        </span>
      </div>
      <div>
        <span className="text-gray-500">Reserved:</span>
        <span className="ml-2 font-medium text-gray-900">
          {formatDate(offer.reserved_at)}
        </span>
      </div>
      <div>
        <span className="text-gray-500">Confirmed:</span>
        <span className="ml-2 font-medium text-gray-900">
          {formatDate(offer.maker_confirmed_at)}
        </span>
      </div>
      <div>
        <span className="text-gray-500">Taker charged:</span>
        <span className="ml-2 font-medium text-gray-900">
          {formatDate(offer.taker_charged_at)}
        </span>
      </div>
      <div>
        <span className="text-gray-500">Client:</span>
        <span className="ml-2 font-mono font-medium text-gray-900">
          {offer.client_version || '-'}
        </span>
      </div>
      <div className="col-span-2 md:col-span-3 xl:col-span-2">
        <span className="text-gray-500">Dispute context:</span>
        <span className="ml-2 font-medium text-gray-900">
          {formatDisputeReason(offer.dispute_escalation_reason)}
        </span>
      </div>
    </div>
  </div>
);

const ActorAvatar = ({ actor, actorPubkey, coordinatorIconUrl = null, size = 24 }) => {
  const [imageFailed, setImageFailed] = useState(false);
  const normalizedActor = (actor || '').toLowerCase();
  const useCoordinatorLogo =
    (normalizedActor === 'coordinator' || normalizedActor === 'server') && coordinatorIconUrl;
  const imageUrl = useCoordinatorLogo
    ? coordinatorIconUrl
    : actorPubkey
      ? buildPubkeyAvatarUrl(actorPubkey)
      : null;
  const fallbackLabel = (actor || '?').slice(0, 1).toUpperCase();

  if (!imageUrl || imageFailed) {
    return (
      <div
        className="inline-flex items-center justify-center rounded-full border border-slate-200 bg-slate-100 font-semibold text-slate-600"
        style={{ width: size, height: size, minWidth: size }}
      >
        <span style={{ fontSize: Math.max(10, Math.floor(size * 0.45)) }}>{fallbackLabel}</span>
      </div>
    );
  }

  return (
    <img
      src={imageUrl}
      alt={`${actor || 'actor'} avatar`}
      width={size}
      height={size}
      className="rounded-full border border-slate-200 bg-slate-100 object-cover"
      style={{ minWidth: size }}
      onError={() => setImageFailed(true)}
    />
  );
};

const OffersPage = ({ selectedCoordinatorId, selectedCoordinatorIconUrl = null, selectedCoordinatorFlowId = null }) => {
  const [offers, setOffers] = useState([]);
  const [connected, setConnected] = useState(false);
  const [selectedOffer, setSelectedOffer] = useState(null);
  const [auditLogs, setAuditLogs] = useState([]);
  const [auditLoading, setAuditLoading] = useState(false);
  const [historyOffer, setHistoryOffer] = useState(null);
  const [stateHistoryRows, setStateHistoryRows] = useState([]);
  const [stateHistoryLoading, setStateHistoryLoading] = useState(false);
  const [selectedTransitionIndex, setSelectedTransitionIndex] = useState(null);
  const [actorOffersDialog, setActorOffersDialog] = useState(null);
  const [actorOffersRows, setActorOffersRows] = useState([]);
  const [actorOffersLoading, setActorOffersLoading] = useState(false);
  const [actorStats, setActorStats] = useState(null);
  const [actorStatsLoading, setActorStatsLoading] = useState(false);
  const [hasMore, setHasMore] = useState(false);
  const [loadingMore, setLoadingMore] = useState(false);
  const [statusFilter, setStatusFilter] = useState('all');
  // Possible statuses for this coordinator, taken from its flow definition.
  // null = no flow configured → fall back to KNOWN_STATUSES.
  const [flowStatuses, setFlowStatuses] = useState(null);
  const wsRef = useRef(null);
  const reconnectTimeoutRef = useRef(null);
  const shouldReconnectRef = useRef(true);
  const offersRef = useRef([]);
  const loadingMoreRef = useRef(false);
  const hasMoreRef = useRef(false);
  const historyFlowScrollRef = useRef(null);
  const shouldStickHistoryFlowRef = useRef(true);
  const previousHistoryLengthRef = useRef(0);

  // Keep refs in sync so the scroll handler reads fresh values without
  // re-binding the listener on every offers update.
  useEffect(() => {
    offersRef.current = offers;
  }, [offers]);
  useEffect(() => {
    loadingMoreRef.current = loadingMore;
  }, [loadingMore]);
  useEffect(() => {
    hasMoreRef.current = hasMore;
  }, [hasMore]);

  useEffect(() => {
    const container = historyFlowScrollRef.current;
    if (!container) return undefined;

    const updateStickiness = () => {
      const distanceFromBottom =
        container.scrollHeight - container.scrollTop - container.clientHeight;
      shouldStickHistoryFlowRef.current = distanceFromBottom <= 24;
    };

    updateStickiness();
    container.addEventListener('scroll', updateStickiness, { passive: true });
    return () => container.removeEventListener('scroll', updateStickiness);
  }, [historyOffer]);

  const fetchStateHistory = useCallback(async (offerId) => {
    setStateHistoryLoading(true);
    try {
      const response = await fetch(buildCoordinatorApiUrl(`/api/offers/${offerId}/state-history`, selectedCoordinatorId));
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      const rows = data.rows || [];
      setStateHistoryRows(rows);
      setSelectedTransitionIndex((current) => {
        if (rows.length === 0) return null;
        if (current == null) return rows.length - 1;
        return Math.min(current, rows.length - 1);
      });
    } catch (error) {
      console.error('Failed to fetch state history:', error);
      setStateHistoryRows([]);
      setSelectedTransitionIndex(null);
    } finally {
      setStateHistoryLoading(false);
    }
  }, [selectedCoordinatorId]);

  const fetchActorOffers = useCallback(async (actorPubkey) => {
    setActorOffersLoading(true);
    try {
      const response = await fetch(
        buildCoordinatorApiUrl(`/api/actors/${encodeURIComponent(actorPubkey)}/offers?limit=20`, selectedCoordinatorId)
      );
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      setActorOffersRows(data.rows || []);
    } catch (error) {
      console.error('Failed to fetch actor offers:', error);
      setActorOffersRows([]);
    } finally {
      setActorOffersLoading(false);
    }
  }, [selectedCoordinatorId]);

  const connectWebSocket = useCallback(() => {
    if (wsRef.current && wsRef.current.readyState === WebSocket.OPEN) {
      return;
    }

    shouldReconnectRef.current = true;
    const ws = new WebSocket(buildCoordinatorWebSocketUrl(selectedCoordinatorId));

    ws.onopen = () => {
      setConnected(true);
      if (reconnectTimeoutRef.current) {
        clearTimeout(reconnectTimeoutRef.current);
        reconnectTimeoutRef.current = null;
      }
    };

    ws.onclose = () => {
      setConnected(false);
      if (shouldReconnectRef.current) {
        reconnectTimeoutRef.current = setTimeout(() => {
          connectWebSocket();
        }, 3000);
      }
    };

    ws.onerror = () => {
      setConnected(false);
    };

    ws.onmessage = (event) => {
      try {
        const message = JSON.parse(event.data);

        switch (message.type) {
          case 'offers_snapshot': {
            const snapshot = message.offers || [];
            setOffers(snapshot);
            setHasMore(snapshot.length >= OFFERS_PAGE_SIZE);
            break;
          }

          case 'offer_changed':
            setOffers((prev) => {
              const existingIndex = prev.findIndex((o) => o.id === message.offer.id);
              if (existingIndex >= 0) {
                const updated = [...prev];
                updated[existingIndex] = message.offer;
                return updated.sort((a, b) => {
                  const dateA = new Date(a.created_at);
                  const dateB = new Date(b.created_at);
                  return dateB - dateA;
                });
              }
              return [message.offer, ...prev];
            });

            setSelectedOffer((prev) => {
              if (prev && prev.id === message.offer.id) {
                return message.offer;
              }
              return prev;
            });
            setHistoryOffer((currentOffer) => {
              if (currentOffer && currentOffer.id === message.offer.id) {
                fetchStateHistory(message.offer.id);
                return message.offer;
              }
              return currentOffer;
            });
            break;

          case 'offer_removed':
            setOffers((prev) => prev.filter((o) => o.id !== message.offerId));
            setSelectedOffer((prev) => {
              if (prev && prev.id === message.offerId) {
                setAuditLogs([]);
                return null;
              }
              return prev;
            });
            setHistoryOffer((prev) => (prev && prev.id === message.offerId ? null : prev));
            break;

          case 'audit_changed':
            if (message.audit && message.offerId) {
              setSelectedOffer((currentOffer) => {
                if (currentOffer && currentOffer.id === message.offerId) {
                  setAuditLogs((prev) => {
                    const existingIndex = prev.findIndex((a) => a.id === message.audit.id);
                    if (existingIndex >= 0) {
                      const updated = [...prev];
                      updated[existingIndex] = message.audit;
                      return updated;
                    }
                    return [message.audit, ...prev];
                  });
                }
                return currentOffer;
              });
            }
            break;

          default:
            break;
        }
      } catch (error) {
        console.error('Failed to parse WebSocket message:', error);
      }
    };

    wsRef.current = ws;
  }, [fetchStateHistory, selectedCoordinatorId]);

  useEffect(() => {
    connectWebSocket();

    return () => {
      shouldReconnectRef.current = false;
      if (reconnectTimeoutRef.current) {
        clearTimeout(reconnectTimeoutRef.current);
      }
      if (wsRef.current) {
        wsRef.current.close();
      }
    };
  }, [connectWebSocket]);

  useEffect(() => {
    setSelectedOffer(null);
    setAuditLogs([]);
    setHistoryOffer(null);
    setStateHistoryRows([]);
    setSelectedTransitionIndex(null);
  }, [selectedCoordinatorId]);

  useEffect(() => {
    const previousOverflow = document.body.style.overflow;
    const previousOverscrollBehavior = document.body.style.overscrollBehavior;

    if (selectedOffer || historyOffer) {
      document.body.style.overflow = 'hidden';
      document.body.style.overscrollBehavior = 'contain';
    }

    return () => {
      document.body.style.overflow = previousOverflow;
      document.body.style.overscrollBehavior = previousOverscrollBehavior;
    };
  }, [selectedOffer, historyOffer]);

  useEffect(() => {
    const container = historyFlowScrollRef.current;
    const currentLength = stateHistoryRows.length;
    const previousLength = previousHistoryLengthRef.current;

    if (container && currentLength > previousLength && shouldStickHistoryFlowRef.current) {
      container.scrollTop = container.scrollHeight;
    }

    previousHistoryLengthRef.current = currentLength;
  }, [stateHistoryRows]);

  const loadMoreOffers = useCallback(async () => {
    if (loadingMoreRef.current || !hasMoreRef.current) return;
    loadingMoreRef.current = true;
    setLoadingMore(true);
    try {
      const offset = offersRef.current.length;
      const response = await fetch(buildCoordinatorApiUrl(`/api/offers/recent?limit=${OFFERS_PAGE_SIZE}&offset=${offset}`, selectedCoordinatorId));
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      const newRows = data.rows || [];
      setOffers((prev) => {
        const seen = new Set(prev.map((o) => o.id));
        const merged = [...prev];
        for (const row of newRows) {
          if (!seen.has(row.id)) merged.push(row);
        }
        return merged;
      });
      setHasMore(data.hasMore ?? newRows.length >= OFFERS_PAGE_SIZE);
    } catch (error) {
      console.error('Failed to load more offers:', error);
    } finally {
      loadingMoreRef.current = false;
      setLoadingMore(false);
    }
  }, [selectedCoordinatorId]);

  useEffect(() => {
    const onScroll = () => {
      const scrollBottom = window.innerHeight + window.scrollY;
      const threshold = document.documentElement.scrollHeight - 400;
      if (scrollBottom >= threshold) {
        loadMoreOffers();
      }
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => window.removeEventListener('scroll', onScroll);
  }, [loadMoreOffers]);

  // When filtering by a specific status, keep pulling more pages until enough
  // matches are collected or all offers are loaded — matches may live on pages
  // beyond the first.
  useEffect(() => {
    if (statusFilter === 'all' || !hasMore || loadingMore) return;
    const matches = offers.filter((offer) => offer.status === statusFilter).length;
    if (matches >= OFFERS_PAGE_SIZE) return;
    loadMoreOffers();
  }, [statusFilter, offers, hasMore, loadingMore, loadMoreOffers]);

  // Load the coordinator's flow definition to know which statuses are possible.
  // The flow states are the source of truth for the status filter pills.
  useEffect(() => {
    setStatusFilter('all');
    if (!selectedCoordinatorFlowId) {
      setFlowStatuses(null);
      return undefined;
    }
    let cancelled = false;
    fetch(buildCoordinatorApiUrl(`/api/flows/${selectedCoordinatorFlowId}`))
      .then((res) => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.json();
      })
      .then((data) => {
        if (cancelled) return;
        const names = (data.states || []).map((state) => state.name);
        setFlowStatuses(names.length > 0 ? names : null);
      })
      .catch((error) => {
        console.error('Failed to fetch flow definition:', error);
        if (!cancelled) setFlowStatuses(null);
      });
    return () => {
      cancelled = true;
    };
  }, [selectedCoordinatorFlowId]);

  const fetchAuditLogs = async (offerId) => {
    setAuditLoading(true);
    try {
      const response = await fetch(buildCoordinatorApiUrl(`/api/offers/${offerId}/audit`, selectedCoordinatorId));
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      const data = await response.json();
      setAuditLogs(data.rows || []);
    } catch (error) {
      console.error('Failed to fetch audit logs:', error);
      setAuditLogs([]);
    } finally {
      setAuditLoading(false);
    }
  };

  const handleOfferClick = (offer) => {
    setSelectedOffer(offer);
    fetchAuditLogs(offer.id);
  };

  const handleHistoryClick = (offer) => {
    setHistoryOffer(offer);
    setStateHistoryRows([]);
    setSelectedTransitionIndex(null);
    shouldStickHistoryFlowRef.current = true;
    previousHistoryLengthRef.current = 0;
    fetchStateHistory(offer.id);
  };

  const handleCloseDialog = () => {
    setSelectedOffer(null);
    setAuditLogs([]);
  };

  const handleCloseHistoryDialog = () => {
    setHistoryOffer(null);
    setStateHistoryRows([]);
    setSelectedTransitionIndex(null);
    previousHistoryLengthRef.current = 0;
  };

  const handleActorClick = useCallback((actor, actorPubkey) => {
    if (!actorPubkey) {
      return;
    }
    setActorOffersDialog({ actor, actorPubkey });
    setActorOffersRows([]);
    fetchActorOffers(actorPubkey);
  }, [fetchActorOffers]);

  const handleCloseActorOffersDialog = () => {
    setActorOffersDialog(null);
    setActorOffersRows([]);
  };

  const handleActorOfferClick = (offer) => {
    handleOfferClick(offer);
  };

  const handleRefresh = () => {
    if (wsRef.current && wsRef.current.readyState === WebSocket.OPEN) {
      wsRef.current.send(JSON.stringify({ type: 'refresh_offers' }));
    }
  };

  const selectedTransition =
    selectedTransitionIndex != null ? stateHistoryRows[selectedTransitionIndex] || null : null;
  const selectedTransitionClient = parseClientDescriptor(selectedTransition?.metadata?.client);

  useEffect(() => {
    const actor = selectedTransition?.actor;
    const actorPubkey = selectedTransition?.actor_pubkey;
    const isSupportedRole = actor === 'maker' || actor === 'taker';

    if (!selectedTransition || !actorPubkey || !isSupportedRole) {
      setActorStats(null);
      setActorStatsLoading(false);
      return;
    }

    let cancelled = false;
    setActorStatsLoading(true);

    const loadActorStats = async () => {
      try {
        const response = await fetch(
          buildCoordinatorApiUrl(
            `/api/actors/${encodeURIComponent(actorPubkey)}/stats?role=${encodeURIComponent(actor)}&days=90`,
            selectedCoordinatorId
          )
        );
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const data = await response.json();
        if (!cancelled) {
          setActorStats(data);
        }
      } catch (error) {
        console.error('Failed to fetch actor stats:', error);
        if (!cancelled) {
          setActorStats(null);
        }
      } finally {
        if (!cancelled) {
          setActorStatsLoading(false);
        }
      }
    };

    loadActorStats();

    return () => {
      cancelled = true;
    };
  }, [selectedCoordinatorId, selectedTransition]);

  const filterStatuses = flowStatuses ?? KNOWN_STATUSES;
  const filteredOffers =
    statusFilter === 'all'
      ? offers
      : offers.filter((offer) => offer.status === statusFilter);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50 px-6 pb-6 pt-2 sm:px-6 sm:pb-6 sm:pt-3">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="mb-6 relative">
          <div className="absolute inset-0 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg blur-2xl opacity-10"></div>
          <div className="relative backdrop-blur-sm bg-white/80 rounded-lg shadow-lg border border-white/20 px-4 py-3">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-3">
                <List size={20} className="text-blue-600" />
                <h1 className="text-lg font-extrabold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
                  Recent Offers
                </h1>
              </div>

              <div className="flex items-center gap-3">
                <div
                  className={`flex items-center gap-1.5 px-2.5 py-1.5 rounded border ${
                    connected
                      ? 'bg-green-50 border-green-200 text-green-700'
                      : 'bg-red-50 border-red-200 text-red-700'
                  }`}
                >
                  {connected ? <Wifi size={14} /> : <WifiOff size={14} />}
                  <span className="text-xs font-medium">{connected ? 'Live' : 'Disconnected'}</span>
                </div>

                <Link
                  to="/flow"
                  title="Flow state diagram"
                  className="flex items-center gap-1.5 px-3 py-1.5 bg-indigo-50 text-indigo-700 border border-indigo-200 rounded hover:bg-indigo-100 transition-colors text-sm font-medium"
                >
                  <Workflow size={14} />
                  Flow
                </Link>

                <button
                  onClick={handleRefresh}
                  className="flex items-center gap-1.5 px-3 py-1.5 bg-blue-600 text-white rounded hover:bg-blue-700 transition-colors text-sm font-medium"
                >
                  <RefreshCw size={14} />
                  Refresh
                </button>
              </div>
            </div>

            {/* Status filter pills */}
            <div className="mt-3 flex flex-wrap items-center gap-2 border-t border-gray-100 pt-3">
              <button
                onClick={() => setStatusFilter('all')}
                className={`px-2.5 py-1 rounded-full border text-xs font-medium transition-colors ${
                  statusFilter === 'all'
                    ? 'bg-blue-600 text-white border-blue-600'
                    : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-50'
                }`}
              >
                All
              </button>
              {filterStatuses.map((status) => (
                <button
                  key={status}
                  onClick={() => setStatusFilter(status)}
                  className={`px-2.5 py-1 rounded-full border text-xs font-medium transition-colors ${
                    statusFilter === status
                      ? STATUS_COLORS[status]
                        ? `${STATUS_COLORS[status]} ring-2 ring-offset-1 ring-current`
                        : 'bg-gray-800 text-white border-gray-800'
                      : STATUS_COLORS[status]
                      ? `${STATUS_COLORS[status]} opacity-70 hover:opacity-100`
                      : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-50'
                  }`}
                >
                  {status}
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Offers Table */}
        <div className="bg-white rounded-xl shadow-lg border border-gray-200 overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="bg-gradient-to-r from-gray-50 to-gray-100 border-b border-gray-200">
                  <th className="text-left px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    ID
                  </th>
                  <th className="text-left px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Status
                  </th>
                  <th className="text-right px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Premium
                  </th>
                  <th className="text-right px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Amount
                  </th>
                  <th className="text-left px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Category
                  </th>
                  <th className="text-left px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Client
                  </th>
                  <th className="text-right px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Time to Reserve
                  </th>
                  <th className="text-right px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Time to Paid
                  </th>
                  <th className="text-right px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Taker Invoice Routing Fees
                  </th>
                  <th className="text-right px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Profit
                  </th>
                  <th className="text-center px-4 py-3 text-xs font-bold text-gray-600 uppercase tracking-wide">
                    Actions
                  </th>
                </tr>
              </thead>
              <tbody>
                {filteredOffers.length === 0 ? (
                  <tr>
                    <td colSpan={11} className="px-4 py-12 text-center text-gray-500">
                      {offers.length === 0
                        ? 'No offers found'
                        : loadingMore && hasMore
                        ? `Searching more pages for status "${statusFilter}"…`
                        : `No offers with status "${statusFilter}"`}
                    </td>
                  </tr>
                ) : (
                  groupOffersByDay(filteredOffers).flatMap((group) => [
                    <tr key={`day-${group.dayLabel}`}>
                      <td colSpan={11} className="px-4 pt-4 pb-1">
                        <div className="flex items-center gap-3">
                          <span className="text-xs font-bold text-gray-400 uppercase tracking-widest whitespace-nowrap">
                            {group.dayLabel}
                          </span>
                          <div className="flex-1 h-px bg-gray-200" />
                        </div>
                      </td>
                    </tr>,
                    ...group.offers.map((offer) => (
                      <tr
                        key={offer.id}
                        className="border-b border-gray-100 hover:bg-blue-50/50 transition-colors cursor-pointer"
                        onClick={() => handleOfferClick(offer)}
                      >
                        <td className="px-4 py-3">
                          <span className="font-mono text-sm text-gray-700">
                            {offer.id.substring(0, 8)}...
                          </span>
                        </td>
                        <td className="px-4 py-3">
                          <div className="flex flex-col gap-1">
                            <span
                              className={`inline-flex w-fit items-center px-2.5 py-1 rounded-full text-xs font-semibold border ${
                                STATUS_COLORS[offer.status] || 'bg-gray-100 text-gray-800 border-gray-300'
                              }`}
                            >
                              {offer.status}
                            </span>
                            {(offer.taker_charged_at || offer.dispute_escalation_reason) && (
                              <div className="text-[11px] leading-4 text-gray-500">
                                {offer.taker_charged_at && (
                                  <div>Taker charged: {formatDate(offer.taker_charged_at)}</div>
                                )}
                                {offer.dispute_escalation_reason && (
                                  <div>{formatDisputeReason(offer.dispute_escalation_reason)}</div>
                                )}
                              </div>
                            )}
                          </div>
                        </td>
                        <td className="px-4 py-3 text-right">
                          {(() => {
                            const p = offer.premium_percent;
                            if (p == null || p === '') return <span className="text-gray-400 text-xs">-</span>;
                            const val = parseFloat(p);
                            if (isNaN(val) || val === 0) return <span className="text-gray-400 text-xs">-</span>;
                            const color = val > 0 ? 'text-emerald-700' : 'text-red-600';
                            return (
                              <span className={`font-mono text-sm ${color}`}>
                                {val > 0 ? '+' : ''}{val.toFixed(2)}%
                              </span>
                            );
                          })()}
                        </td>
                        <td className="px-4 py-3 text-right">
                          <div className="flex flex-col items-end gap-0.5">
                            <span className="font-medium text-base text-emerald-700">
                              {formatCurrency(offer.fiat_amount, offer.fiat_currency)}
                            </span>
                            <span className="font-mono text-xs text-gray-500">
                              {formatSats(offer.amount_sats)} sats
                            </span>
                          </div>
                        </td>
                        <td className="px-4 py-3">
                          {offer.category ? (
                            <span
                              className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold border ${CATEGORY_COLORS[offer.category] || 'bg-slate-100 text-slate-700 border-slate-300'}`}
                              style={CATEGORY_INLINE_STYLES[offer.category] || {}}
                            >
                              {offer.category}
                            </span>
                          ) : (
                            <span className="text-gray-400 text-xs">-</span>
                          )}
                        </td>
                        <td className="px-4 py-3">
                          {offer.client_version ? (
                            <span className="font-mono text-xs text-gray-700">
                              {offer.client_version}
                            </span>
                          ) : (
                            <span className="text-gray-400 text-xs">-</span>
                          )}
                        </td>
                        <td className="px-4 py-3 text-right">
                          <span className="font-mono text-sm text-gray-700">
                            {calcDuration(offer.created_at, offer.reserved_at) ?? <span className="text-gray-400">-</span>}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-right">
                          <span className="font-mono text-sm text-gray-700">
                            {calcDuration(offer.created_at, offer.taker_paid_at) ?? <span className="text-gray-400">-</span>}
                          </span>
                        </td>
                        <td className="px-4 py-3 text-right whitespace-nowrap">
                          {(() => {
                            const feeSats = offer.taker_invoice_fees;
                            const feePct = calcTakerFeePct(offer.taker_invoice_fees, offer.amount_sats);
                            if (feeSats == null) return <span className="text-gray-400 text-xs">-</span>;
                            return (
                              <div className="flex flex-col items-end gap-0.5">
                                <span className="font-mono text-sm text-gray-900">{formatSats(feeSats)} sats</span>
                                {feePct != null && (
                                  <span className="text-xs text-gray-500">{feePct.toFixed(2)}%</span>
                                )}
                              </div>
                            );
                          })()}
                        </td>
                        <td className="px-4 py-3 text-right whitespace-nowrap">
                          {(() => {
                            const finishedStatuses = ['settled', 'takerPaid'];
                            if (!finishedStatuses.includes(offer.status)) return <span className="text-gray-400 text-xs">-</span>;
                            const profitSats = calcProfit(offer.maker_fees, offer.taker_fees, offer.taker_invoice_fees);
                            const profitFiat = calcProfitFiat(profitSats, offer.fiat_amount, offer.amount_sats);
                            if (profitSats == null) return <span className="text-gray-400 text-xs">-</span>;
                            const color = profitSats >= 0 ? 'text-emerald-700' : 'text-red-600';
                            return (
                              <div className="flex flex-col items-end gap-0.5">
                                <span className={`font-mono text-sm font-medium ${color}`}>{formatSats(profitSats)} sats</span>
                                {profitFiat != null && (
                                  <span className={`text-xs ${color}`}>{formatCurrency(profitFiat, offer.fiat_currency)}</span>
                                )}
                              </div>
                            );
                          })()}
                        </td>
                        <td className="px-4 py-3 text-center">
                          <div className="flex items-center justify-center gap-2">
                          <button
                            title="View state history"
                            aria-label={`View state history for offer ${offer.id}`}
                            className="inline-flex items-center justify-center rounded-md border border-violet-200 bg-violet-50 p-2 text-violet-700 hover:bg-violet-100 hover:text-violet-900 transition-colors"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleHistoryClick(offer);
                            }}
                          >
                            <GitBranch size={14} />
                          </button>
                          <button
                            className="inline-flex items-center gap-1 px-2 py-1 text-xs font-medium text-blue-600 hover:text-blue-800 hover:bg-blue-100 rounded transition-colors"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleOfferClick(offer);
                            }}
                          >
                            View Logs
                            <ChevronRight size={12} />
                          </button>
                          </div>
                        </td>
                      </tr>
                    )),
                  ])
                )}
              </tbody>
            </table>
          </div>
          {loadingMore && (
            <div className="flex items-center justify-center py-6">
              <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-blue-600"></div>
            </div>
          )}
          {!hasMore && offers.length > 0 && (
            <div className="py-4 text-center text-xs text-gray-400">
              End of offers
            </div>
          )}
        </div>

        {/* Audit Log Dialog */}
        {selectedOffer && (
          <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-[70] p-4">
            <div className="bg-white rounded-xl shadow-2xl w-full max-w-4xl max-h-[90vh] min-h-0 flex flex-col">
              {/* Dialog Header */}
              <div className="flex items-center justify-between px-6 py-4 border-b border-gray-200 bg-gradient-to-r from-gray-50 to-gray-100 rounded-t-xl">
                <div>
                  <h2 className="text-lg font-bold text-gray-900">Offer Audit Logs</h2>
                  <p className="text-sm text-gray-500 font-mono mt-0.5">{selectedOffer.id}</p>
                </div>
                <div className="flex items-center gap-3">
                  <span
                    className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-semibold border ${
                      STATUS_COLORS[selectedOffer.status] || 'bg-gray-100 text-gray-800 border-gray-300'
                    }`}
                  >
                    {selectedOffer.status}
                  </span>
                  <button
                    onClick={handleCloseDialog}
                    className="p-1.5 hover:bg-gray-200 rounded-full transition-colors"
                  >
                    <X size={20} className="text-gray-500" />
                  </button>
                </div>
              </div>

              {/* Offer Summary */}
              {renderOfferSummary(selectedOffer)}

              {/* Audit Logs List */}
              <div className="min-h-0 flex-1 overflow-y-auto p-6">
                {auditLoading ? (
                  <div className="flex items-center justify-center py-12">
                    <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
                  </div>
                ) : auditLogs.length === 0 ? (
                  <div className="text-center py-12 text-gray-500">
                    No audit logs found for this offer
                  </div>
                ) : (
                  <div className="space-y-3">
                    {auditLogs.map((log) => (
                      <div
                        key={log.id}
                        className={`p-4 rounded-lg border ${
                          log.level === 'error'
                            ? 'bg-red-50 border-red-200'
                            : log.level === 'warn'
                            ? 'bg-amber-50 border-amber-200'
                            : 'bg-gray-50 border-gray-200'
                        }`}
                      >
                        <div className="flex items-start justify-between gap-4">
                          <div className="flex items-start gap-2 flex-1 min-w-0">
                            {LEVEL_ICONS[log.level] || LEVEL_ICONS.info}
                            <div className="flex-1 min-w-0">
                              <div className="flex items-center gap-2 flex-wrap">
                                <span className="font-semibold text-gray-900 text-sm">
                                  {log.action || 'unknown'}
                                </span>
                                <span className="text-xs text-gray-500 font-mono">
                                  {log.logger_name}
                                </span>
                              </div>
                              <p className="text-sm text-gray-700 mt-1 break-words">{log.message}</p>
                              {log.error && (
                                <p className="text-sm text-red-600 mt-1 font-mono break-words">
                                  {log.error}
                                </p>
                              )}
                              {log.metadata && Object.keys(log.metadata).length > 0 && (
                                <pre className="text-xs text-gray-600 mt-2 bg-white/50 p-2 rounded overflow-x-auto">
                                  {JSON.stringify(log.metadata, null, 2)}
                                </pre>
                              )}
                            </div>
                          </div>
                          <div className="text-xs text-gray-500 whitespace-nowrap">
                            {formatDate(log.created_at)}
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </div>

              {/* Dialog Footer */}
              <div className="px-6 py-4 border-t border-gray-200 bg-gray-50 rounded-b-xl">
                <div className="flex items-center justify-between">
                  <span className="text-sm text-gray-500">
                    {auditLogs.length} log{auditLogs.length !== 1 ? 's' : ''} found
                  </span>
                  <button
                    onClick={handleCloseDialog}
                    className="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition-colors text-sm font-medium"
                  >
                    Close
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {historyOffer && (
          <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
            <div className="flex h-[92vh] min-h-0 w-full max-w-7xl flex-col overflow-hidden rounded-xl bg-white shadow-2xl">
              <div className="flex items-center justify-between border-b border-gray-200 bg-gradient-to-r from-violet-50 to-blue-50 px-6 py-4">
                <div>
                  <h2 className="text-lg font-bold text-gray-900">Offer State History</h2>
                  <p className="mt-0.5 font-mono text-sm text-gray-500">{historyOffer.id}</p>
                </div>
                <div className="flex items-center gap-3">
                  <span
                    className={`inline-flex items-center rounded-full border px-2.5 py-1 text-xs font-semibold ${
                      STATUS_COLORS[historyOffer.status] || 'bg-gray-100 text-gray-800 border-gray-300'
                    }`}
                  >
                    {historyOffer.status}
                  </span>
                  <button
                    onClick={handleCloseHistoryDialog}
                    className="rounded-full p-1.5 transition-colors hover:bg-white/70"
                  >
                    <X size={20} className="text-gray-500" />
                  </button>
                </div>
              </div>

              {renderOfferSummary(historyOffer)}

              <div className="min-h-0 flex-1 overflow-hidden bg-gradient-to-br from-white via-slate-50 to-violet-50/40 p-6">
                {stateHistoryLoading ? (
                  <div className="flex h-full items-center justify-center py-16">
                    <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-violet-600"></div>
                  </div>
                ) : stateHistoryRows.length === 0 ? (
                  <div className="mx-auto h-full max-w-2xl overflow-y-auto rounded-2xl border border-dashed border-slate-300 bg-white/80 px-6 py-12 text-center">
                    <div className="mx-auto mb-4 flex h-12 w-12 items-center justify-center rounded-full bg-slate-100 text-slate-600">
                      <GitBranch size={20} />
                    </div>
                    <h3 className="text-lg font-semibold text-slate-900">No state-history rows for this offer</h3>
                    <p className="mt-2 text-sm text-slate-600">
                      This usually means the offer was handled by a legacy coordinator flow, or it predates generic
                      flow history recording.
                    </p>
                    <button
                      onClick={() => {
                        const offer = historyOffer;
                        handleCloseHistoryDialog();
                        if (offer) {
                          handleOfferClick(offer);
                        }
                      }}
                      className="mt-5 inline-flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white transition-colors hover:bg-blue-700"
                    >
                      Open Audit Logs
                      <ChevronRight size={14} />
                    </button>
                  </div>
                ) : (
                  <div className="grid h-full min-h-0 overflow-hidden gap-6 xl:grid-cols-[minmax(0,1.7fr)_minmax(320px,0.9fr)]">
                    <div
                      ref={historyFlowScrollRef}
                      className="h-full min-h-0 overflow-y-auto overscroll-contain rounded-2xl border border-slate-200 bg-white/90 p-5 shadow-sm"
                    >
                      <div className="mb-4 flex items-center justify-between">
                        <div>
                          <h3 className="text-base font-semibold text-slate-900">Taken Path</h3>
                          <p className="text-sm text-slate-500">
                            Ordered by transition time from genesis to the current offer state.
                          </p>
                        </div>
                        <div className="text-xs text-slate-500">
                          {stateHistoryRows.length} transition{stateHistoryRows.length !== 1 ? 's' : ''}
                        </div>
                      </div>

                      <div className="mx-auto w-[860px] max-w-full space-y-0">
                        {stateHistoryRows[0]?.from_state ? (
                          <div className="mb-2 grid w-full grid-cols-[minmax(0,0.55fr)_420px_minmax(340px,460px)]">
                            <div />
                            <div className={`inline-flex w-[420px] max-w-full justify-center rounded-xl border px-5 py-4 text-center text-base font-semibold shadow-sm ${getStateClasses(stateHistoryRows[0].from_state)}`}>
                              {stateHistoryRows[0].from_state}
                            </div>
                          </div>
                        ) : (
                          <div className="mb-2 grid w-full grid-cols-[minmax(0,0.55fr)_420px_minmax(340px,460px)]">
                            <div />
                            <div className="flex w-[420px] max-w-full flex-col items-center gap-3">
                              <div className="flex h-8 w-8 items-center justify-center rounded-full bg-emerald-100 text-emerald-700 ring-4 ring-emerald-50">
                                <CheckCircle size={16} />
                              </div>
                              <div className="rounded-full border border-emerald-200 bg-emerald-50 px-3 py-1 text-xs font-semibold uppercase tracking-wide text-emerald-700">
                                Start
                              </div>
                            </div>
                          </div>
                        )}

                        {stateHistoryRows.map((transition, index) => {
                          const isSelected = index === selectedTransitionIndex;
                          const effects = normalizeMetadataArray(transition.metadata, 'effects');
                          const onEntry = normalizeMetadataArray(transition.metadata, 'on_entry');
                          const hasDetails = effects.length > 0 || onEntry.length > 0 || transition.actor_pubkey || transition.event || transition.actor;
                          const clientDescriptor = parseClientDescriptor(transition.metadata?.client);
                          const previousTimestamp =
                            index === 0
                              ? historyOffer?.created_at
                              : stateHistoryRows[index - 1]?.created_at;
                          const transitionDuration = calcDurationBetweenDates(previousTimestamp, transition.created_at);

                          return (
                            <div key={`${transition.created_at}-${transition.to_state}-${index}`} className="relative flex flex-col items-center pb-8">
                              <div className="relative z-10 grid w-full grid-cols-[minmax(0,0.55fr)_420px_minmax(340px,460px)] pb-4">
                                <div />
                                <div className="relative col-span-2 h-8 overflow-visible">
                                  <div className="absolute left-[210px] top-0 flex h-8 w-8 -translate-x-1/2 items-center justify-center rounded-full bg-white">
                                    <ArrowDown size={16} className="text-slate-400" />
                                  </div>

                                  <div className="absolute left-[236px] right-0 top-0 min-w-0">
                                  <button
                                    type="button"
                                    onClick={() => setSelectedTransitionIndex(index)}
                                    className={`w-full rounded-xl border border-slate-200 bg-white px-3 py-2 text-left shadow-sm transition ${
                                      isSelected
                                        ? 'ring-2 ring-violet-100 border-violet-300'
                                        : 'hover:border-slate-300 hover:bg-slate-50'
                                    }`}
                                    title={`${transition.trigger_type} ${getTransitionEventLabel(transition)}${transition.actor ? ` by ${transition.actor}` : ''}`}
                                  >
                                    <div className="flex items-start justify-between gap-3">
                                      <div className="flex min-w-0 items-center gap-2 overflow-hidden whitespace-nowrap">
                                        <button
                                          type="button"
                                          onClick={(event) => {
                                            event.stopPropagation();
                                            handleActorClick(transition.actor, transition.actor_pubkey);
                                          }}
                                          disabled={!transition.actor_pubkey}
                                          className={`inline-flex shrink-0 items-center gap-2 text-xs font-medium text-slate-600 ${
                                            transition.actor_pubkey ? 'cursor-pointer' : 'cursor-default'
                                          }`}
                                        >
                                          <ActorAvatar
                                            actor={transition.actor}
                                            actorPubkey={transition.actor_pubkey}
                                            coordinatorIconUrl={selectedCoordinatorIconUrl}
                                            size={20}
                                          />
                                          <span>{transition.actor || 'system'}</span>
                                        </button>
                                        {clientDescriptor && <ClientIcons client={clientDescriptor.raw} size={13} />}
                                        <span className="truncate text-sm font-semibold text-slate-900">
                                          {getTransitionEventLabel(transition)}
                                        </span>
                                      </div>

                                      <div className="flex items-center gap-2 whitespace-nowrap pl-2 text-xs text-slate-500">
                                        {transitionDuration && <span>{transitionDuration}</span>}
                                        {hasDetails && (
                                          <span
                                            title="Click this transition to show full details in the right panel."
                                            className="inline-flex h-4 w-4 items-center justify-center rounded-full border border-slate-300 text-[10px] font-bold leading-none text-slate-500"
                                          >
                                            i
                                          </span>
                                        )}
                                      </div>
                                    </div>
                                  </button>
                                </div>
                                </div>
                              </div>

                              <div className="grid w-full grid-cols-[minmax(0,0.55fr)_420px_minmax(340px,460px)]">
                                <div />
                                <div className={`inline-flex w-[420px] max-w-full justify-center rounded-xl border px-5 py-4 text-center text-base font-semibold shadow-sm ${getStateClasses(transition.to_state)}`}>
                                  {transition.to_state}
                                </div>
                              </div>
                            </div>
                          );
                        })}
                      </div>
                    </div>

                    <div className="h-full min-h-0 overflow-y-auto overscroll-contain rounded-2xl border border-slate-200 bg-white/95 p-5 shadow-sm">
                      <h3 className="text-base font-semibold text-slate-900">Transition Details</h3>
                      {selectedTransition ? (
                        <div className="mt-4 space-y-4">
                          <div className="rounded-xl border border-slate-200 bg-slate-50 p-4">
                            <div className="flex flex-wrap items-center gap-2">
                              <span className={`inline-flex items-center gap-1 rounded-full border px-2 py-1 text-[11px] font-semibold uppercase tracking-wide ${getTriggerStyle(selectedTransition.trigger_type).badge}`}>
                                {getTriggerStyle(selectedTransition.trigger_type).icon}
                                {selectedTransition.trigger_type}
                              </span>
                              <span className="text-sm font-semibold text-slate-900">
                                {getTransitionEventLabel(selectedTransition)}
                              </span>
                            </div>

                            <div className="mt-3 grid gap-3 text-sm">
                              <div>
                                <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">Path</div>
                                <div className="mt-1 font-mono text-slate-800">
                                  {selectedTransition.from_state || 'start'} {'->'} {selectedTransition.to_state}
                                </div>
                              </div>
                              <div>
                                <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">Actor</div>
                                <button
                                  type="button"
                                  onClick={() => handleActorClick(selectedTransition.actor, selectedTransition.actor_pubkey)}
                                  disabled={!selectedTransition.actor_pubkey}
                                  className={`mt-1 inline-flex items-center gap-2 text-slate-800 ${
                                    selectedTransition.actor_pubkey ? 'cursor-pointer' : 'cursor-default'
                                  }`}
                                >
                                  <ActorAvatar
                                    actor={selectedTransition.actor}
                                    actorPubkey={selectedTransition.actor_pubkey}
                                    coordinatorIconUrl={selectedCoordinatorIconUrl}
                                    size={24}
                                  />
                                  <span>{selectedTransition.actor || '-'}</span>
                                </button>
                              </div>
                              <div>
                                <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">Actor Pubkey</div>
                                <div className="mt-1 font-mono text-slate-800">{shortenPubkey(selectedTransition.actor_pubkey)}</div>
                              </div>
                              {selectedTransitionClient && (
                                <div>
                                  <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">Client</div>
                                  <div className="mt-1 inline-flex items-center gap-2 text-slate-800">
                                    <ClientIcons client={selectedTransitionClient.raw} size={16} />
                                    <span>{selectedTransitionClient.fullName}</span>
                                  </div>
                                </div>
                              )}
                              {(selectedTransition.actor === 'maker' || selectedTransition.actor === 'taker') && (
                                <div>
                                  <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">
                                    Last 90 Days
                                  </div>
                                  <div className="mt-1 text-slate-800">
                                    {actorStatsLoading ? (
                                      <span className="text-sm text-slate-500">Loading actor stats...</span>
                                    ) : actorStats ? (
                                      <span className="text-sm">
                                        <span className="font-semibold text-emerald-700">{actorStats.successCount}</span> successful
                                        <span className="mx-2 text-slate-400">/</span>
                                        <span className="font-semibold text-rose-700">{actorStats.failedCount}</span> failed
                                      </span>
                                    ) : (
                                      <span className="text-sm text-slate-500">No actor stats available.</span>
                                    )}
                                  </div>
                                </div>
                              )}
                              <div>
                                <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">Timestamp</div>
                                <div className="mt-1 text-slate-800">
                                  {formatDate(selectedTransition.created_at)}
                                  <span className="ml-2 text-slate-500">({formatRelativeTime(selectedTransition.created_at)})</span>
                                </div>
                              </div>
                            </div>
                          </div>

                          <div>
                            {normalizeMetadataArray(selectedTransition.metadata, 'effects').length > 0 && (
                              <>
                                <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">Effects</div>
                                <div className="mt-2 flex flex-wrap gap-2">
                                  {normalizeMetadataArray(selectedTransition.metadata, 'effects').map((effect) => (
                                    <span key={effect} className="rounded-full border border-blue-200 bg-blue-50 px-2.5 py-1 text-xs font-medium text-blue-700">
                                      {effect}
                                    </span>
                                  ))}
                                </div>
                              </>
                            )}
                          </div>

                          <div>
                            {normalizeMetadataArray(selectedTransition.metadata, 'on_entry').length > 0 && (
                              <>
                                <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">On Entry</div>
                                <div className="mt-2 flex flex-wrap gap-2">
                                  {normalizeMetadataArray(selectedTransition.metadata, 'on_entry').map((effect) => (
                                    <span key={effect} className="rounded-full border border-violet-200 bg-violet-50 px-2.5 py-1 text-xs font-medium text-violet-700">
                                      {effect}
                                    </span>
                                  ))}
                                </div>
                              </>
                            )}
                          </div>

                          {historyOffer.dispute_escalation_reason && (
                            <div className="rounded-xl border border-rose-200 bg-rose-50 p-4">
                              <div className="text-xs font-semibold uppercase tracking-wide text-rose-600">Failure or Dispute Context</div>
                              <div className="mt-1 text-sm text-rose-900">
                                {formatDisputeReason(historyOffer.dispute_escalation_reason)}
                              </div>
                            </div>
                          )}

                          {selectedTransition.metadata && Object.keys(selectedTransition.metadata).length > 0 && (
                            <div>
                              <div className="text-xs font-semibold uppercase tracking-wide text-slate-500">Raw Metadata</div>
                              <pre className="mt-2 overflow-x-auto rounded-xl border border-slate-200 bg-slate-50 p-3 text-xs text-slate-700">
                                {JSON.stringify(selectedTransition.metadata, null, 2)}
                              </pre>
                            </div>
                          )}
                        </div>
                      ) : (
                        <div className="mt-4 rounded-xl border border-dashed border-slate-300 bg-slate-50 p-6 text-sm text-slate-500">
                          Select a transition to inspect the full cause and side effects.
                        </div>
                      )}
                    </div>
                  </div>
                )}
              </div>

              <div className="flex items-center justify-between border-t border-gray-200 bg-gray-50 px-6 py-4 rounded-b-xl">
                <span className="text-sm text-gray-500">
                  {stateHistoryRows.length} transition{stateHistoryRows.length !== 1 ? 's' : ''} recorded
                </span>
                <div className="flex items-center gap-3">
                  <button
                    onClick={() => {
                      const offer = historyOffer;
                      handleCloseHistoryDialog();
                      if (offer) {
                        handleOfferClick(offer);
                      }
                    }}
                    className="rounded-lg border border-blue-200 bg-white px-4 py-2 text-sm font-medium text-blue-700 transition-colors hover:bg-blue-50"
                  >
                    View Audit Logs
                  </button>
                  <button
                    onClick={handleCloseHistoryDialog}
                    className="rounded-lg bg-gray-200 px-4 py-2 text-sm font-medium text-gray-700 transition-colors hover:bg-gray-300"
                  >
                    Close
                  </button>
                </div>
              </div>
            </div>
          </div>
        )}

        {actorOffersDialog && (
          <div className="fixed inset-0 z-[60] flex items-center justify-center bg-black/50 p-4">
            <div className="flex max-h-[80vh] w-full max-w-2xl min-h-0 flex-col overflow-hidden rounded-xl bg-white shadow-2xl">
              <div className="flex items-center justify-between border-b border-gray-200 px-6 py-4">
                <div>
                  <h3 className="text-lg font-bold text-gray-900">Recent Actor Offers</h3>
                  <div className="mt-1 inline-flex items-center gap-2 text-sm text-slate-600">
                    <ActorAvatar
                      actor={actorOffersDialog.actor}
                      actorPubkey={actorOffersDialog.actorPubkey}
                      coordinatorIconUrl={selectedCoordinatorIconUrl}
                      size={24}
                    />
                    <span className="font-medium">{actorOffersDialog.actor || 'actor'}</span>
                    <span className="font-mono text-xs text-slate-500">
                      {shortenPubkey(actorOffersDialog.actorPubkey)}
                    </span>
                  </div>
                </div>
                <button
                  onClick={handleCloseActorOffersDialog}
                  className="rounded-full p-1.5 transition-colors hover:bg-gray-100"
                >
                  <X size={20} className="text-gray-500" />
                </button>
              </div>

              <div className="min-h-0 flex-1 overflow-y-auto p-6">
                {actorOffersLoading ? (
                  <div className="flex items-center justify-center py-12">
                    <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-blue-600"></div>
                  </div>
                ) : actorOffersRows.length === 0 ? (
                  <div className="py-12 text-center text-gray-500">
                    No recent offers found for this actor.
                  </div>
                ) : (
                  <div className="space-y-3">
                    {actorOffersRows.map((offer) => (
                      <button
                        key={offer.id}
                        type="button"
                        onClick={() => handleActorOfferClick(offer)}
                        className="w-full rounded-xl border border-slate-200 bg-slate-50 p-4 text-left transition hover:border-blue-200 hover:bg-blue-50"
                      >
                        <div className="flex items-start justify-between gap-4">
                          <div className="min-w-0">
                            <div className="flex flex-wrap items-center gap-2">
                              <span className="font-mono text-sm text-slate-800">
                                {offer.id.slice(0, 8)}...
                              </span>
                              <span
                                className={`inline-flex items-center rounded-full border px-2 py-0.5 text-[11px] font-semibold ${
                                  STATUS_COLORS[offer.status] || 'bg-gray-100 text-gray-800 border-gray-300'
                                }`}
                              >
                                {offer.status}
                              </span>
                              <span className="inline-flex items-center rounded-full border border-slate-200 bg-white px-2 py-0.5 text-[11px] font-semibold uppercase tracking-wide text-slate-600">
                                {offer.role}
                              </span>
                            </div>
                            <div className="mt-2 text-sm text-slate-600">
                              {formatCurrency(offer.fiat_amount, offer.fiat_currency)}
                            </div>
                          </div>
                          <div className="shrink-0 text-xs text-slate-500">
                            {formatDate(offer.created_at)}
                          </div>
                        </div>
                      </button>
                    ))}
                  </div>
                )}
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default OffersPage;
