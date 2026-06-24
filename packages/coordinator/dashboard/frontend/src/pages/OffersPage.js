import React, { useState, useEffect, useRef, useCallback } from 'react';
import { List, RefreshCw, Wifi, WifiOff, ChevronRight, X, AlertTriangle, Info, CheckCircle, XCircle } from 'lucide-react';
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
  reserved: 'bg-blue-100 text-blue-800 border-blue-300',
  blikReceived: 'bg-indigo-100 text-indigo-800 border-indigo-300',
  makerConfirmed: 'bg-purple-100 text-purple-800 border-purple-300',
  settled: 'bg-teal-100 text-teal-800 border-teal-300',
  takerPaid: 'bg-green-100 text-green-800 border-green-300',
  expired: 'bg-gray-100 text-gray-800 border-gray-300',
  cancelled: 'bg-red-100 text-red-800 border-red-300',
  failed: 'bg-red-100 text-red-800 border-red-300',
};

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

const calcTakerFeePct = (taker_invoice_fees, amount_sats) => {
  if (!taker_invoice_fees || !amount_sats || amount_sats === 0) return null;
  return (taker_invoice_fees * 100) / amount_sats;
};

const calcProfit = (maker_fees, taker_fees, taker_invoice_fees) => {
  if (maker_fees == null && taker_fees == null) return null;
  return (maker_fees || 0) + (taker_fees || 0) - (taker_invoice_fees || 0);
};

const calcProfitFiat = (profit_sats, fiat_amount, amount_sats) => {
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

const formatDisputeReason = (reason) => {
  if (!reason) return '-';
  return DISPUTE_REASON_LABELS[reason] || reason;
};

const OffersPage = ({ selectedCoordinatorId }) => {
  const [offers, setOffers] = useState([]);
  const [connected, setConnected] = useState(false);
  const [selectedOffer, setSelectedOffer] = useState(null);
  const [auditLogs, setAuditLogs] = useState([]);
  const [auditLoading, setAuditLoading] = useState(false);
  const [hasMore, setHasMore] = useState(false);
  const [loadingMore, setLoadingMore] = useState(false);
  const wsRef = useRef(null);
  const reconnectTimeoutRef = useRef(null);
  const shouldReconnectRef = useRef(true);
  const offersRef = useRef([]);
  const loadingMoreRef = useRef(false);
  const hasMoreRef = useRef(false);

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
  }, [selectedCoordinatorId]);

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

  const handleCloseDialog = () => {
    setSelectedOffer(null);
    setAuditLogs([]);
  };

  const handleRefresh = () => {
    if (wsRef.current && wsRef.current.readyState === WebSocket.OPEN) {
      wsRef.current.send(JSON.stringify({ type: 'refresh_offers' }));
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50 p-6">
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

                <button
                  onClick={handleRefresh}
                  className="flex items-center gap-1.5 px-3 py-1.5 bg-blue-600 text-white rounded hover:bg-blue-700 transition-colors text-sm font-medium"
                >
                  <RefreshCw size={14} />
                  Refresh
                </button>
              </div>
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
                {offers.length === 0 ? (
                  <tr>
                    <td colSpan={11} className="px-4 py-12 text-center text-gray-500">
                      No offers found
                    </td>
                  </tr>
                ) : (
                  groupOffersByDay(offers).flatMap((group) => [
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
          <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-xl shadow-2xl w-full max-w-4xl max-h-[90vh] flex flex-col">
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
              <div className="px-6 py-3 bg-blue-50 border-b border-blue-100">
                <div className="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-6 gap-4 text-sm">
                  <div>
                    <span className="text-gray-500">Amount:</span>
                    <span className="ml-2 font-medium text-gray-900">
                      {formatSats(selectedOffer.amount_sats)} sats
                    </span>
                  </div>
                  <div>
                    <span className="text-gray-500">Fiat:</span>
                    <span className="ml-2 font-medium text-emerald-700">
                      {formatCurrency(selectedOffer.fiat_amount, selectedOffer.fiat_currency)}
                    </span>
                  </div>
                  <div>
                    <span className="text-gray-500">Created:</span>
                    <span className="ml-2 font-medium text-gray-900">
                      {formatDate(selectedOffer.created_at)}
                    </span>
                  </div>
                  <div>
                    <span className="text-gray-500">Reserved:</span>
                    <span className="ml-2 font-medium text-gray-900">
                      {formatDate(selectedOffer.reserved_at)}
                    </span>
                  </div>
                  <div>
                    <span className="text-gray-500">Confirmed:</span>
                    <span className="ml-2 font-medium text-gray-900">
                      {formatDate(selectedOffer.maker_confirmed_at)}
                    </span>
                  </div>
                  <div>
                    <span className="text-gray-500">Taker charged:</span>
                    <span className="ml-2 font-medium text-gray-900">
                      {formatDate(selectedOffer.taker_charged_at)}
                    </span>
                  </div>
                  <div>
                    <span className="text-gray-500">Client:</span>
                    <span className="ml-2 font-mono font-medium text-gray-900">
                      {selectedOffer.client_version || '-'}
                    </span>
                  </div>
                  <div className="col-span-2 md:col-span-3 xl:col-span-2">
                    <span className="text-gray-500">Dispute context:</span>
                    <span className="ml-2 font-medium text-gray-900">
                      {formatDisputeReason(selectedOffer.dispute_escalation_reason)}
                    </span>
                  </div>
                </div>
              </div>

              {/* Audit Logs List */}
              <div className="flex-1 overflow-y-auto p-6">
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
      </div>
    </div>
  );
};

export default OffersPage;
