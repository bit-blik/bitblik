import React, { startTransition, useEffect, useState } from 'react';
import { BrowserRouter, Routes, Route, Link, useLocation } from 'react-router-dom';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { Calendar, TrendingUp, DollarSign, AlertCircle, Clock, Bitcoin, List, BarChart3, ChevronLeft, ChevronRight } from 'lucide-react';
import './App.css';
import OffersPage from './pages/OffersPage';
import FlowPage from './pages/FlowPage';
import { buildCoordinatorApiUrl, COORDINATOR_STORAGE_KEY } from './coordinators';

// Stable, saturated colors for known categories; unknowns fall back to the
// palette. Pill *background* pastels (lime-100/blue-100/...) are near-white and
// render as washed-out/grey bars, so use vivid hues here for legibility.
const CATEGORY_CHART_COLORS = {
  shop: '#ef4444',    // red-500
  atm: '#10b981',     // emerald-500
  online: '#3b82f6',  // blue-500
  unknown: '#94a3b8', // slate-400
};
const CATEGORY_FALLBACK_PALETTE = ['#f59e0b', '#ec4899', '#8b5cf6', '#14b8a6', '#ef4444', '#6366f1'];
const categoryColor = (key, index) =>
  CATEGORY_CHART_COLORS[key] || CATEGORY_FALLBACK_PALETTE[index % CATEGORY_FALLBACK_PALETTE.length];

// One distinct line color per client build (app-bitblik/<v>, app-bitway/<v>,
// cli/<v>, unknown, ...). Distinct from the category palette.
const CLIENT_CHART_PALETTE = ['#2563eb', '#16a34a', '#db2777', '#f59e0b', '#7c3aed', '#0891b2', '#dc2626', '#65a30d'];
const clientColor = (key, index) =>
  key === 'unknown' ? '#94a3b8' : CLIENT_CHART_PALETTE[index % CLIENT_CHART_PALETTE.length];

// Locale per currency for Intl number formatting. Falls back to the browser
// default when a currency isn't listed.
const CURRENCY_LOCALES = {
  PLN: 'pl-PL', EUR: 'de-DE', USD: 'en-US', GBP: 'en-GB', CHF: 'de-CH',
  CZK: 'cs-CZ', HUF: 'hu-HU', RON: 'ro-RO', SEK: 'sv-SE', NOK: 'nb-NO',
  DKK: 'da-DK', BGN: 'bg-BG', UAH: 'uk-UA',
};
const localeForCurrency = (currency) => CURRENCY_LOCALES[currency] || undefined;

// BTC/<currency> rate sources. Each builds its request URL and response parser
// from the active currency so rate fetching follows the offers' currency.
const buildExchangeRateSources = (currency) => {
  const lower = currency.toLowerCase();
  const upper = currency.toUpperCase();
  return [
    {
      name: 'CoinGecko',
      url: `https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=${lower}`,
      parser: (data) => data?.bitcoin?.[lower],
    },
    {
      name: 'Yadio',
      url: `https://api.yadio.io/exrates/${upper}`,
      parser: (data) => data?.BTC,
    },
    {
      name: 'Blockchain.info',
      url: 'https://blockchain.info/ticker',
      parser: (data) => data?.[upper]?.last,
    },
  ];
};

const Navigation = ({ coordinators, selectedCoordinatorId, onCoordinatorChange, loading }) => {
  const location = useLocation();

  return (
    <nav className="fixed top-4 left-1/2 -translate-x-1/2 z-50 w-[min(96vw,56rem)]">
      <div className="bg-white/90 backdrop-blur-sm rounded-2xl shadow-lg border border-gray-200 px-2 py-1.5 flex items-center justify-between gap-1 sm:px-3 sm:py-2 sm:gap-2">
        <div className="flex gap-1 min-w-0">
          <Link
            to="/"
            className={`flex items-center justify-center gap-1 px-2.5 py-1.5 rounded-full text-xs font-medium transition-all sm:gap-1.5 sm:px-4 sm:py-2 sm:text-sm ${
              location.pathname === '/'
                ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
                : 'text-gray-600 hover:bg-gray-100'
            }`}
          >
            <BarChart3 size={14} className="sm:h-4 sm:w-4" />
            Analytics
          </Link>
          <Link
            to="/offers"
            className={`flex items-center justify-center gap-1 px-2.5 py-1.5 rounded-full text-xs font-medium transition-all sm:gap-1.5 sm:px-4 sm:py-2 sm:text-sm ${
              location.pathname === '/offers'
                ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
                : 'text-gray-600 hover:bg-gray-100'
            }`}
          >
            <List size={14} className="sm:h-4 sm:w-4" />
            Offers
          </Link>
        </div>

        <div className="flex items-center min-w-0">
          <div className="bg-white/90 backdrop-blur-sm rounded-full border border-gray-200 px-1 py-0.5 flex gap-1 min-w-0 sm:px-1.5 sm:py-1">
            {loading && (
              <span className="px-2 py-1.5 text-xs font-medium text-gray-500 sm:px-3 sm:py-2 sm:text-sm">Loading...</span>
            )}
            {!loading && coordinators.map((coordinator) => (
              <button
                key={coordinator.id}
                type="button"
                onClick={() => onCoordinatorChange(coordinator.id)}
                className={`max-w-[7.25rem] truncate px-2.5 py-1.5 rounded-full text-xs font-medium transition-all sm:max-w-none sm:px-4 sm:py-2 sm:text-sm ${
                  selectedCoordinatorId === coordinator.id
                    ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
                    : 'text-gray-600 hover:bg-gray-100'
                }`}
                title={coordinator.label}
              >
                <span className="flex items-center gap-1.5 min-w-0">
                  {coordinator.iconUrl && (
                    <img
                      src={coordinator.iconUrl}
                      alt=""
                      className="h-4 w-4 rounded-full object-cover flex-shrink-0"
                    />
                  )}
                  <span className="truncate">{coordinator.label}</span>
                </span>
              </button>
            ))}
          </div>
        </div>
      </div>
    </nav>
  );
};

const AnalyticsDashboard = ({ selectedCoordinatorId }) => {
  const [data, setData] = useState([]);
  const [totals, setTotals] = useState(null);
  const [weekdaySuccess, setWeekdaySuccess] = useState([]);
  const [weekdayVolume, setWeekdayVolume] = useState([]);
  const [categoryData, setCategoryData] = useState([]);
  const [categoryVolumeData, setCategoryVolumeData] = useState([]);
  const [categoryKeys, setCategoryKeys] = useState([]);
  const [clientData, setClientData] = useState([]);
  const [clientKeys, setClientKeys] = useState([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState(null);
  const [groupBy, setGroupBy] = useState('daily');
  const [page, setPage] = useState(0);
  // Optional custom date-range filter (YYYY-MM-DD). Both set together or null.
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [showDateFilters, setShowDateFilters] = useState(false);
  const [pagination, setPagination] = useState(null);
  // Currency is detected from the offers returned by the API and drives both
  // fiat formatting and the BTC rate source below. Defaults to PLN.
  const [currency, setCurrency] = useState('PLN');
  const [btcFiatRate, setBtcFiatRate] = useState(null);
  const [rateLoading, setRateLoading] = useState(true);
  const [rateError, setRateError] = useState(null);
  const [lastRateFetchTime, setLastRateFetchTime] = useState(null);

  // Fetch BTC/<currency> rate from all sources and calculate average
  const fetchBtcFiatRate = async () => {
    setRateLoading(true);
    setRateError(null);

    try {
      const exchangeRateSources = buildExchangeRateSources(currency);
      const fetchPromises = exchangeRateSources.map(async (source) => {
        try {
          const response = await fetch(source.url);
          if (!response.ok) {
            console.warn(`Failed to fetch from ${source.name}: ${response.status}`);
            return null;
          }
          const data = await response.json();
          const rate = source.parser(data);
          if (rate && typeof rate === 'number' && rate > 0) {
            console.log(`Fetched rate from ${source.name}: ${rate} ${currency}/BTC`);
            return rate;
          }
          console.warn(`Invalid rate from ${source.name}: ${rate}`);
          return null;
        } catch (err) {
          console.warn(`Error fetching from ${source.name}:`, err);
          return null;
        }
      });

      const results = await Promise.all(fetchPromises);
      const validRates = results.filter((rate) => rate !== null);

      if (validRates.length > 0) {
        const averageRate = validRates.reduce((a, b) => a + b, 0) / validRates.length;
        setBtcFiatRate(averageRate);
        setLastRateFetchTime(new Date());
        console.log(`Average BTC/${currency} rate: ${averageRate} (from ${validRates.length} sources)`);
      } else {
        throw new Error(`Failed to fetch BTC/${currency} rate from all sources`);
      }
    } catch (err) {
      console.error(`Error fetching BTC/${currency} rate:`, err);
      setRateError(err.message);
    } finally {
      setRateLoading(false);
    }
  };

  // Refetch the rate whenever the detected currency changes (and on mount).
  useEffect(() => {
    fetchBtcFiatRate();
    // Refresh rate every 5 minutes (matching coordinator cache time)
    const interval = setInterval(fetchBtcFiatRate, 5 * 60 * 1000);
    return () => clearInterval(interval);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currency]);

  // Fetch data from API
  useEffect(() => {
    const fetchData = async () => {
      const isInitialLoad = data.length === 0 && !totals;
      if (isInitialLoad) {
        setLoading(true);
      } else {
        setRefreshing(true);
      }
      setError(null);

      try {
        // groupBy drives SQL grouping; optional startDate/endDate filter the
        // whole dashboard (charts + totals). Both dates required together.
        const rangeActive = startDate && endDate;
        const response = await fetch(buildCoordinatorApiUrl('/api/offers-data', selectedCoordinatorId), {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(
            rangeActive ? { groupBy, page, startDate, endDate } : { groupBy, page }
          )
        });

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const result = await response.json();
        if (result.currency) setCurrency(result.currency);
        setData(result.rows || []);
        setTotals(result.totals || null);
        setPagination(result.pagination || null);
        setWeekdaySuccess(
          (result.weekdaySuccess || []).map((item) => ({
            ...item,
            success_count: parseInt(item.success_count || 0, 10),
            avg_offer_count: parseFloat(item.avg_offer_count || 0),
          }))
        );
        setWeekdayVolume(
          (result.weekdayVolume || []).map((item) => ({
            ...item,
            total_volume_fiat: parseFloat(item.total_volume_fiat || 0),
            avg_volume_fiat: parseFloat(item.avg_volume_fiat || 0),
          }))
        );

        // Pivot category distribution into per-period rows for a stacked bar
        // chart: { date, <category>: count, ... }. Categories discovered
        // dynamically so new categories appear without code changes.
        const catRows = result.categoryDistribution || [];
        const keys = [];
        const byDate = new Map();
        const volByDate = new Map();
        catRows.forEach((row) => {
          const key = row.category || 'unknown';
          if (!keys.includes(key)) keys.push(key);
          if (!byDate.has(row.date)) byDate.set(row.date, { date: row.date });
          if (!volByDate.has(row.date)) volByDate.set(row.date, { date: row.date });
          byDate.get(row.date)[key] = parseInt(row.count || 0, 10);
          volByDate.get(row.date)[key] = parseFloat(row.volume || 0);
        });
        keys.sort();
        const fillZeros = (entry) => {
          keys.forEach((key) => {
            if (entry[key] == null) entry[key] = 0;
          });
          return entry;
        };
        setCategoryKeys(keys);
        setCategoryData(Array.from(byDate.values()).map(fillZeros));
        setCategoryVolumeData(Array.from(volByDate.values()).map(fillZeros));

        // Pivot client-version distribution into per-period rows for a
        // multi-line chart: { date, <client>: count, ... }. Client builds
        // discovered dynamically so new app/cli versions appear automatically.
        const clientRows = result.clientVersionDistribution || [];
        const cKeys = [];
        const cByDate = new Map();
        clientRows.forEach((row) => {
          const key = row.client || 'unknown';
          if (!cKeys.includes(key)) cKeys.push(key);
          if (!cByDate.has(row.date)) cByDate.set(row.date, { date: row.date });
          cByDate.get(row.date)[key] = parseInt(row.count || 0, 10);
        });
        cKeys.sort();
        const fillClientZeros = (entry) => {
          cKeys.forEach((key) => {
            if (entry[key] == null) entry[key] = 0;
          });
          return entry;
        };
        setClientKeys(cKeys);
        setClientData(Array.from(cByDate.values()).map(fillClientZeros));
      } catch (err) {
        setError(err.message);
        console.error('Error fetching data:', err);
      } finally {
        setLoading(false);
        setRefreshing(false);
      }
    };

    // `data`/`totals` intentionally omitted to avoid re-fetch loop.
    // Only refetch on range change once both bounds are set, or both cleared.
    if (!selectedCoordinatorId) return;
    if (startDate && !endDate) return;
    if (endDate && !startDate) return;
    fetchData();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [groupBy, page, selectedCoordinatorId, startDate, endDate]);

  const formatCurrency = (value) => {
    return new Intl.NumberFormat(localeForCurrency(currency), {
      style: 'currency',
      currency,
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    }).format(value);
  };

  const formatNumber = (value) => {
    return new Intl.NumberFormat('en-US').format(value);
  };

  const formatCurrencyChart = (value) => {
    return new Intl.NumberFormat(localeForCurrency(currency), {
      style: 'currency',
      currency,
      minimumFractionDigits: 2,
      maximumFractionDigits: 2,
    }).format(value);
  };

  const formatRateTime = (date) => {
    if (!date) return '';
    return new Intl.DateTimeFormat('pl-PL', {
      hour: '2-digit',
      minute: '2-digit',
      timeZone: 'Europe/Warsaw',
    }).format(date);
  };

  const formatTime = (seconds) => {
    if (!seconds || isNaN(seconds)) return '0:00';
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const formatPagerDate = (value) => {
    const date = new Date(`${value}T00:00:00`);
    return new Intl.DateTimeFormat('en-GB', {
      day: 'numeric',
      month: 'long',
      timeZone: 'UTC',
    }).format(date);
  };

  const formatPeriodRange = () => {
    if (!data.length) return 'No data';
    return `${formatPagerDate(data[0].date)} - ${formatPagerDate(data[data.length - 1].date)}`;
  };

  const formatCompactPeriodRange = () => {
    if (!data.length) return 'No data';
    const formatCompactDate = (value) => {
      const date = new Date(`${value}T00:00:00`);
      return new Intl.DateTimeFormat('en-GB', {
        day: 'numeric',
        month: 'short',
        timeZone: 'UTC',
      }).format(date);
    };
    return `${formatCompactDate(data[0].date)} - ${formatCompactDate(data[data.length - 1].date)}`;
  };

  const hasPartialDateRange = Boolean(startDate || endDate);
  const hasActiveDateRange = Boolean(startDate && endDate);
  const metricValueClass = 'text-[clamp(0.8rem,4vw,1.5rem)] sm:text-2xl font-extrabold leading-tight tracking-tight';
  const metricUnitClass = 'text-[clamp(0.7rem,2.8vw,0.875rem)] sm:text-sm font-medium';

  // Convert sats to the active fiat currency using the fetched rate
  const satsToFiat = (sats) => {
    if (!btcFiatRate || !sats) return 0;
    const btc = sats / 100000000; // Convert sats to BTC
    return btc * btcFiatRate;
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Loading dashboard data...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-screen bg-gray-50">
        <div className="bg-red-50 border border-red-200 rounded-lg p-6 max-w-md">
          <div className="flex items-start gap-3">
            <AlertCircle className="text-red-600 mt-0.5 flex-shrink-0" size={24} />
            <div>
              <h3 className="text-red-800 font-semibold mb-2">Failed to load data</h3>
              <p className="text-red-700 text-sm mb-3">{error}</p>
              <p className="text-red-600 text-xs">Make sure the API server is running on http://localhost:3001</p>
              <button
                onClick={() => window.location.reload()}
                className="mt-4 px-4 py-2 bg-red-600 text-white rounded-md text-sm hover:bg-red-700 transition-colors"
              >
                Retry
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  const stats = totals ? {
    totalVolume: parseFloat(totals.total_volume || 0),
    totalVolumeSats: parseFloat(totals.total_volume_sats || 0),
    totalProfitSats: parseFloat(totals.total_profit || 0),
    avgSuccess: parseFloat(totals.overall_success_percentage || 0),
    totalSuccess: parseInt(totals.total_success || 0),
    totalFailed: parseInt(totals.total_failed || 0),
    avgTimeToAccept: parseFloat(totals.overall_avg_reserved_seconds || 0),
    avgTimeToFullPayment: parseFloat(totals.overall_avg_total_seconds || 0),
    avgTakerInvoiceFees: parseFloat(totals.overall_avg_taker_invoice_fees || 0),
    takerFeesPercentage: parseFloat(totals.overall_taker_fees_percentage || 0),
  } : {};

  // Calculate profit in the active fiat currency
  const totalProfitFiat = satsToFiat(stats.totalProfitSats);

  const contentLoadingClass = refreshing ? 'opacity-60 transition-opacity duration-200' : 'opacity-100 transition-opacity duration-200';

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50 px-6 pb-6 pt-2 sm:px-6 sm:pb-6 sm:pt-3">
      <div className="max-w-7xl mx-auto">
        {/* Ultra-Compact Single-Line Header */}
        <div className="mb-4 relative">
          <div className="absolute inset-0 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg blur-2xl opacity-10"></div>
          <div className="relative backdrop-blur-sm bg-white/80 rounded-lg shadow-lg border border-white/20 px-4 py-3">
            <div className="flex flex-col gap-3 lg:flex-row lg:items-center">
              {/* Title - Ultra Compact */}
              <div className="flex min-w-0 flex-wrap items-center gap-2">
                <TrendingUp size={18} className="text-blue-600 flex-shrink-0" />
                <h1 className="text-lg font-extrabold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent sm:whitespace-nowrap">
                  Offers Analytics
                </h1>
                <div className="flex items-center justify-center bg-amber-50 rounded px-2 py-1 border border-amber-200 sm:px-2.5 sm:py-1.5">
                  <div className="flex flex-col items-center">
                    <div className="flex items-center gap-1.5">
                      <Bitcoin size={14} className="text-amber-600 flex-shrink-0" />
                      <span className="text-xs font-semibold text-amber-700 whitespace-nowrap">
                        {rateLoading ? 'Loading...' : rateError ? 'Error' : formatCurrency(btcFiatRate)}
                      </span>
                    </div>
                    {!rateLoading && !rateError && lastRateFetchTime && (
                      <span className="text-[9px] text-amber-500/70 leading-none mt-0.5">
                        {formatRateTime(lastRateFetchTime)}
                      </span>
                    )}
                  </div>
                </div>
              </div>
              
              {/* Flexible Spacer */}
              <div className="hidden lg:block flex-1"></div>

              <div className="flex flex-nowrap items-center gap-2 overflow-x-auto pb-1 lg:flex-wrap lg:justify-end lg:overflow-visible lg:pb-0">
                {/* Separator */}
                <div className="hidden lg:block h-6 w-px bg-gray-300"></div>
                
                {/* Period Selector - Compact Pills */}
                <div className="flex flex-shrink-0 items-center justify-center gap-1 bg-blue-50 rounded px-2 py-1 border border-blue-200 sm:justify-start sm:gap-1.5 sm:px-2.5 sm:py-1.5">
                  <Calendar size={14} className="hidden text-blue-600 flex-shrink-0 sm:block" />
                  {['daily', 'weekly', 'monthly'].map((period) => (
                    <button
                      key={period}
                      onClick={() => {
                        setGroupBy(period);
                        setPage(0);
                      }}
                      className={`px-2 py-0.5 rounded text-[10px] font-bold uppercase transition-all sm:px-2.5 sm:py-1 sm:text-xs ${
                        groupBy === period
                          ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
                          : 'bg-white text-gray-600 hover:bg-gray-100'
                      }`}
                    >
                      {period[0]}
                    </button>
                  ))}
                </div>

                <div className="hidden lg:block h-6 w-px bg-gray-300"></div>

                <div className="flex flex-shrink-0 items-center gap-2 sm:flex-none sm:justify-start">
                  {/* Pager - hidden while a custom date range is active */}
                  {!hasActiveDateRange && (
                    <div className="flex flex-shrink-0 items-center gap-1 bg-slate-50 rounded px-1.5 py-1 border border-slate-200 sm:min-w-[260px] sm:flex-none sm:gap-1.5 sm:px-2 sm:py-1.5">
                      <button
                        onClick={() => setPage((current) => current + 1)}
                        disabled={!pagination?.hasOlder || loading || refreshing}
                        className="p-0.5 rounded bg-white text-slate-600 hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed sm:p-1"
                        aria-label="Older period"
                      >
                        <ChevronLeft size={14} />
                      </button>
                      <span className="flex-1 truncate text-[10px] font-semibold text-slate-700 text-center min-w-0 px-0.5 sm:px-1 sm:text-[11px]">
                        <span className="sm:hidden">{formatCompactPeriodRange()}</span>
                        <span className="hidden sm:inline">{formatPeriodRange()}</span>
                      </span>
                      <button
                        onClick={() => setPage((current) => Math.max(current - 1, 0))}
                        disabled={!pagination?.hasNewer || loading || refreshing}
                        className="p-0.5 rounded bg-white text-slate-600 hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed sm:p-1"
                        aria-label="Newer period"
                      >
                        <ChevronRight size={14} />
                      </button>
                    </div>
                  )}

                  <button
                    type="button"
                    onClick={() => setShowDateFilters((current) => !current)}
                    className={`flex flex-shrink-0 items-center gap-1 rounded px-2 py-1 border transition-colors sm:gap-1.5 sm:px-2.5 sm:py-1.5 ${
                      hasPartialDateRange || showDateFilters
                        ? 'bg-emerald-50 border-emerald-200 text-emerald-700'
                        : 'bg-white border-gray-200 text-gray-600 hover:bg-gray-50'
                    }`}
                    aria-label="Toggle date range filter"
                    aria-expanded={showDateFilters}
                  >
                    <Calendar size={14} className="flex-shrink-0" />
                    {hasActiveDateRange && !showDateFilters && (
                      <span className="hidden text-[11px] font-semibold whitespace-nowrap sm:inline">
                        Filter on
                      </span>
                    )}
                  </button>
                </div>

                {refreshing && (
                  <>
                    <div className="hidden lg:block h-6 w-px bg-gray-300"></div>
                    <div className="hidden sm:block text-[11px] font-semibold text-blue-600 whitespace-nowrap text-center sm:text-left">
                      Updating...
                    </div>
                  </>
                )}
              </div>

              {showDateFilters && (
                <div className="flex justify-end">
                  <div className="flex min-w-0 flex-wrap items-center justify-center gap-1 bg-emerald-50 rounded px-2 py-1 border border-emerald-200 sm:justify-start sm:gap-1.5 sm:px-2.5 sm:py-1.5">
                    <input
                      type="date"
                      lang="en-GB"
                      value={startDate}
                      max={endDate || undefined}
                      onChange={(e) => {
                        setStartDate(e.target.value);
                        setPage(0);
                      }}
                      className="min-w-0 text-[10px] font-semibold text-emerald-800 bg-white rounded px-1 py-0.5 border border-emerald-200 focus:outline-none focus:ring-1 focus:ring-emerald-400 sm:px-1.5 sm:text-[11px]"
                      aria-label="Start date"
                    />
                    <span className="text-[10px] font-semibold text-emerald-600 sm:text-[11px]">→</span>
                    <input
                      type="date"
                      lang="en-GB"
                      value={endDate}
                      min={startDate || undefined}
                      onChange={(e) => {
                        setEndDate(e.target.value);
                        setPage(0);
                      }}
                      className="min-w-0 text-[10px] font-semibold text-emerald-800 bg-white rounded px-1 py-0.5 border border-emerald-200 focus:outline-none focus:ring-1 focus:ring-emerald-400 sm:px-1.5 sm:text-[11px]"
                      aria-label="End date"
                    />
                    {hasPartialDateRange && (
                      <button
                        onClick={() => {
                          setStartDate('');
                          setEndDate('');
                          setPage(0);
                        }}
                        className="text-[10px] font-bold text-emerald-700 hover:text-emerald-900 px-1 sm:text-[11px]"
                        aria-label="Clear date range"
                      >
                        Clear
                      </button>
                    )}
                    <button
                      type="button"
                      onClick={() => setShowDateFilters(false)}
                      className="text-[10px] font-bold text-gray-500 hover:text-gray-700 px-1 sm:text-[11px]"
                      aria-label="Close date range filter"
                    >
                      Done
                    </button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>

        {!totals ? (
          <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-6 text-center">
            <AlertCircle className="text-yellow-600 mx-auto mb-3" size={32} />
            <p className="text-yellow-800 font-medium">No data available</p>
            <p className="text-yellow-700 text-sm mt-1">There are no offers matching the selected criteria.</p>
          </div>
        ) : (
          <>
            {/* Compact Stats Row - Using Horizontal Space Efficiently */}
            <div className={`grid grid-cols-2 lg:grid-cols-4 gap-4 mb-6 ${contentLoadingClass}`}>
              {/* Total Volume Card - Compact */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-emerald-400 to-green-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-4 border border-green-100 hover:border-green-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-emerald-400 to-green-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <Bitcoin className="text-white" size={18} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <p className="text-xs font-bold text-green-800 uppercase tracking-wide">Volume</p>
                        <span className="text-xs font-semibold text-emerald-600">
                          ≈ {formatCurrency(stats.totalVolume)}
                        </span>
                      </div>
                      <div className="flex items-baseline gap-1.5">
                        <p className={`${metricValueClass} bg-gradient-to-r from-emerald-600 to-green-600 bg-clip-text text-transparent whitespace-nowrap`}>
                          {formatNumber(stats.totalVolumeSats)}
                        </p>
                        <span className={`${metricUnitClass} hidden text-green-600 sm:inline`}>sats</span>
                      </div>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-emerald-400 to-green-600 rounded-full"></div>
                </div>
              </div>

              {/* Total Profit Card - Horizontal Space Optimized */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-blue-400 to-indigo-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-3 border border-blue-100 hover:border-blue-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-blue-400 to-indigo-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <TrendingUp className="text-white" size={20} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <div className="flex items-center gap-2">
                        <p className="text-xs font-bold text-blue-800 uppercase tracking-wide">Profit</p>
                        {btcFiatRate && !rateLoading && (
                          <span className="text-xs font-semibold text-indigo-500">
                            ≈ {formatCurrency(totalProfitFiat)}
                          </span>
                        )}
                      </div>
                      <div className="flex items-baseline gap-1.5">
                        <p className={`${metricValueClass} bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent whitespace-nowrap`}>
                          {formatNumber(stats.totalProfitSats)}
                        </p>
                        <span className={`${metricUnitClass} hidden text-blue-600 sm:inline`}>sats</span>
                      </div>
                    </div>
                  </div>
                  <div className="mt-1.5 h-0.5 bg-gradient-to-r from-blue-400 to-indigo-600 rounded-full"></div>
                </div>
              </div>

              {/* Avg Success Rate Card - Compact */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-purple-400 to-pink-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-4 border border-purple-100 hover:border-purple-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-purple-400 to-pink-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <TrendingUp className="text-white" size={18} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs font-bold text-purple-800 uppercase tracking-wide mb-1">Success Rate</p>
                      <p className={`${metricValueClass} bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent`}>
                        {stats.avgSuccess?.toFixed(1)}%
                      </p>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-purple-400 to-pink-600 rounded-full"></div>
                </div>
              </div>

              {/* Success/Failed Card - Compact */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-amber-400 to-orange-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-4 border border-orange-100 hover:border-orange-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-amber-400 to-orange-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <Calendar className="text-white" size={18} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs font-bold text-orange-800 uppercase tracking-wide mb-1">Success/Failed</p>
                      <p className={`${metricValueClass} bg-gradient-to-r from-amber-600 to-orange-600 bg-clip-text text-transparent`}>
                        {formatNumber(stats.totalSuccess)}/{formatNumber(stats.totalFailed)}
                      </p>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-amber-400 to-orange-600 rounded-full"></div>
                </div>
              </div>

              {/* Time to Accept Card - Compact */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-cyan-400 to-blue-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-4 border border-cyan-100 hover:border-cyan-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-cyan-400 to-blue-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <Clock className="text-white" size={18} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs font-bold text-cyan-800 uppercase tracking-wide mb-1">Time to Accept</p>
                      <p className={`${metricValueClass} bg-gradient-to-r from-cyan-600 to-blue-600 bg-clip-text text-transparent`}>
                        {formatTime(stats.avgTimeToAccept)}
                      </p>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-cyan-400 to-blue-600 rounded-full"></div>
                </div>
              </div>

              {/* Time to Full Payment Card - Compact */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-teal-400 to-emerald-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-4 border border-teal-100 hover:border-teal-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-teal-400 to-emerald-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <Clock className="text-white" size={18} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs font-bold text-teal-800 uppercase tracking-wide mb-1">Time to Payment</p>
                      <p className={`${metricValueClass} bg-gradient-to-r from-teal-600 to-emerald-600 bg-clip-text text-transparent`}>
                        {formatTime(stats.avgTimeToFullPayment)}
                      </p>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-teal-400 to-emerald-600 rounded-full"></div>
                </div>
              </div>

              {/* Avg Taker Invoice Fees Card - Compact */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-rose-400 to-pink-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-4 border border-rose-100 hover:border-rose-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-rose-400 to-pink-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <DollarSign className="text-white" size={18} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs font-bold text-rose-800 uppercase tracking-wide mb-1">Avg Taker Fees</p>
                      <div className="flex items-baseline gap-1.5">
                        <p className={`${metricValueClass} bg-gradient-to-r from-rose-600 to-pink-600 bg-clip-text text-transparent whitespace-nowrap`}>
                          {formatNumber(stats.avgTakerInvoiceFees)}
                        </p>
                        <span className={`${metricUnitClass} hidden text-rose-600 sm:inline`}>sats</span>
                      </div>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-rose-400 to-pink-600 rounded-full"></div>
                </div>
              </div>

              {/* Taker Fees Percentage Card - Compact */}
              <div className="group relative overflow-hidden">
                <div className="absolute inset-0 bg-gradient-to-br from-violet-400 to-purple-600 rounded-xl blur-xl opacity-20 group-hover:opacity-30 transition-opacity duration-300"></div>
                <div className="relative backdrop-blur-sm bg-white rounded-xl shadow-md hover:shadow-xl transition-all duration-300 p-4 border border-violet-100 hover:border-violet-300 hover:-translate-y-1">
                  <div className="flex items-center gap-3">
                    <div className="bg-gradient-to-br from-violet-400 to-purple-600 rounded-lg p-2 shadow-md flex-shrink-0">
                      <TrendingUp className="text-white" size={18} />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-xs font-bold text-violet-800 uppercase tracking-wide mb-1">Fees % of Amount</p>
                      <p className={`${metricValueClass} bg-gradient-to-r from-violet-600 to-purple-600 bg-clip-text text-transparent`}>
                        {stats.takerFeesPercentage?.toFixed(2)}%
                      </p>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-violet-400 to-purple-600 rounded-full"></div>
                </div>
              </div>
            </div>

            <div className={`grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6 ${contentLoadingClass}`}>
              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-purple-500"></div>
                  Success Rate Trend
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis domain={[0, 100]} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Line type="monotone" dataKey="success_percentage" stroke="#8b5cf6" strokeWidth={2} name="Success %" dot={{ fill: '#8b5cf6', r: 4 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>

              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-green-500"></div>
                  Volume ({currency})
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip formatter={(value) => formatCurrency(value)} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Bar dataKey="volume" fill="#10b981" name="Volume" />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </div>

            <div className={`grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6 ${contentLoadingClass}`}>
              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-blue-500"></div>
                  Success vs Failed Offers
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Bar dataKey="success" fill="#3b82f6" name="Success" />
                    <Bar dataKey="failed" fill="#ef4444" name="Failed" />
                  </BarChart>
                </ResponsiveContainer>
              </div>

              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-amber-500"></div>
                  Profit Trend (Sats & {currency})
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={data.map(d => ({
                    ...d,
                    profit_fiat: satsToFiat(parseFloat(d.profit || 0))
                  }))}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis yAxisId="left" tick={{ fill: '#6b7280', fontSize: 12 }} label={{ value: 'Sats', angle: -90, position: 'insideLeft', style: { fill: '#f59e0b' } }} />
                    <YAxis yAxisId="right" orientation="right" tick={{ fill: '#6b7280', fontSize: 12 }} tickFormatter={(value) => value.toFixed(2)} label={{ value: currency, angle: 90, position: 'insideRight', style: { fill: '#10b981' } }} />
                    <Tooltip
                      formatter={(value, name) => {
                        if (name === `Profit (${currency})`) return [formatCurrencyChart(value), name];
                        return [formatNumber(value) + ' sats', name];
                      }}
                      contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }}
                    />
                    <Legend />
                    <Line yAxisId="left" type="monotone" dataKey="profit" stroke="#f59e0b" strokeWidth={2} name="Profit (Sats)" dot={{ fill: '#f59e0b', r: 4 }} />
                    <Line yAxisId="right" type="monotone" dataKey="profit_fiat" stroke="#10b981" strokeWidth={2} name={`Profit (${currency})`} dot={{ fill: '#10b981', r: 4 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </div>

            <div className={`grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6 ${contentLoadingClass}`}>
              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-cyan-500"></div>
                  Time to first Reservation
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip formatter={(value) => formatTime(value)} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Line type="monotone" dataKey="avg_reserved_seconds" stroke="#06b6d4" strokeWidth={2} name="Time to Accept" dot={{ fill: '#06b6d4', r: 4 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>

              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-teal-500"></div>
                  Time to Full Payment
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip formatter={(value) => formatTime(value)} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Line type="monotone" dataKey="avg_total_seconds" stroke="#14b8a6" strokeWidth={2} name="Time to Payment" dot={{ fill: '#14b8a6', r: 4 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </div>

            <div className={`grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6 ${contentLoadingClass}`}>
              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-orange-500"></div>
                  Volume in Satoshis
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip formatter={(value) => formatNumber(value) + ' sats'} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Bar dataKey="volume_sats" fill="#f97316" name="Volume (sats)" />
                  </BarChart>
                </ResponsiveContainer>
              </div>

              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-rose-500"></div>
                  Avg Taker Invoice Fees Trend
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip formatter={(value) => formatNumber(value) + ' sats'} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Line type="monotone" dataKey="avg_taker_invoice_fees" stroke="#f43f5e" strokeWidth={2} name="Avg Taker Invoice Fees" dot={{ fill: '#f43f5e', r: 4 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </div>

            <div className={`grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6 ${contentLoadingClass}`}>
              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-sky-500"></div>
                  Successful Offers by Weekday (Total)
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={weekdaySuccess}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="weekday" tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis
                      yAxisId="left"
                      tick={{ fill: '#6b7280', fontSize: 12 }}
                      label={{ value: 'Success (Total)', angle: -90, position: 'insideLeft', style: { fill: '#0ea5e9' } }}
                    />
                    <YAxis
                      yAxisId="right"
                      orientation="right"
                      tick={{ fill: '#6b7280', fontSize: 12 }}
                      tickFormatter={(value) => Number(value).toFixed(2)}
                      label={{ value: 'Avg Offers', angle: 90, position: 'insideRight', style: { fill: '#6366f1' } }}
                    />
                    <Tooltip
                      formatter={(value, name) => {
                        if (name === 'Avg Offers') return [Number(value).toFixed(2), name];
                        return [formatNumber(value), name];
                      }}
                      contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }}
                    />
                    <Legend />
                    <Bar yAxisId="left" dataKey="success_count" fill="#0ea5e9" name="Successful Offers" />
                    <Line
                      yAxisId="right"
                      type="monotone"
                      dataKey="avg_offer_count"
                      stroke="#6366f1"
                      strokeWidth={2}
                      name="Avg Offers"
                      dot={{ fill: '#6366f1', r: 4 }}
                    />
                  </BarChart>
                </ResponsiveContainer>
              </div>

              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-emerald-500"></div>
                  Successful Offer Volume by Weekday (Total)
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={weekdayVolume}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="weekday" tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis
                      yAxisId="left"
                      tick={{ fill: '#6b7280', fontSize: 12 }}
                      tickFormatter={(value) => formatCurrencyChart(value)}
                      label={{ value: `Total Volume (${currency})`, angle: -90, position: 'insideLeft', style: { fill: '#10b981' } }}
                    />
                    <YAxis
                      yAxisId="right"
                      orientation="right"
                      tick={{ fill: '#6b7280', fontSize: 12 }}
                      tickFormatter={(value) => formatCurrencyChart(value)}
                      label={{ value: `Avg Volume (${currency})`, angle: 90, position: 'insideRight', style: { fill: '#f59e0b' } }}
                    />
                    <Tooltip
                      formatter={(value, name) => {
                        return [formatCurrencyChart(value), name];
                      }}
                      contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }}
                    />
                    <Legend />
                    <Bar yAxisId="left" dataKey="total_volume_fiat" fill="#10b981" name={`Total Volume (${currency})`} />
                    <Line
                      yAxisId="right"
                      type="monotone"
                      dataKey="avg_volume_fiat"
                      stroke="#f59e0b"
                      strokeWidth={2}
                      name={`Avg Volume (${currency})`}
                      dot={{ fill: '#f59e0b', r: 4 }}
                    />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </div>

            <div className={`grid grid-cols-1 gap-6 mb-6 ${contentLoadingClass}`}>
              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-violet-500"></div>
                  Taker Fees % of Amount Trend
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <Tooltip formatter={(value) => `${value}%`} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Line type="monotone" dataKey="taker_fees_percentage" stroke="#8b5cf6" strokeWidth={2} name="Fees % of Amount" dot={{ fill: '#8b5cf6', r: 4 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </div>

            {categoryKeys.length > 0 && (
              <div className={`grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6 ${contentLoadingClass}`}>
                <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                  <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                    <div className="h-2 w-2 rounded-full bg-indigo-500"></div>
                    Category Distribution (Count)
                  </h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={categoryData}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                      <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                      <YAxis allowDecimals={false} tick={{ fill: '#6b7280', fontSize: 12 }} />
                      <Tooltip formatter={(value) => formatNumber(value)} itemSorter={(item) => -(item.value ?? 0)} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                      <Legend />
                      {categoryKeys.map((key, index) => (
                        <Bar key={key} dataKey={key} stackId="categories" fill={categoryColor(key, index)} name={key} />
                      ))}
                    </BarChart>
                  </ResponsiveContainer>
                </div>

                <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                  <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                    <div className="h-2 w-2 rounded-full bg-emerald-500"></div>
                    Category Distribution (Volume {currency})
                  </h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <BarChart data={categoryVolumeData}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                      <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                      <YAxis tick={{ fill: '#6b7280', fontSize: 12 }} />
                      <Tooltip formatter={(value) => formatCurrency(value)} itemSorter={(item) => -(item.value ?? 0)} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                      <Legend />
                      {categoryKeys.map((key, index) => (
                        <Bar key={key} dataKey={key} stackId="categories" fill={categoryColor(key, index)} name={key} />
                      ))}
                    </BarChart>
                  </ResponsiveContainer>
                </div>
              </div>
            )}

            {clientKeys.length > 0 && (
              <div className={`grid grid-cols-1 gap-6 mb-6 ${contentLoadingClass}`}>
                <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                  <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                    <div className="h-2 w-2 rounded-full bg-blue-500"></div>
                    Offers by Client Version
                  </h3>
                  <ResponsiveContainer width="100%" height={300}>
                    <LineChart data={clientData}>
                      <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                      <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                      <YAxis allowDecimals={false} tick={{ fill: '#6b7280', fontSize: 12 }} />
                      <Tooltip formatter={(value) => formatNumber(value)} itemSorter={(item) => -(item.value ?? 0)} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                      <Legend />
                      {clientKeys.map((key, index) => (
                        <Line key={key} type="monotone" dataKey={key} stroke={clientColor(key, index)} strokeWidth={2} name={key} dot={{ r: 3 }} connectNulls />
                      ))}
                    </LineChart>
                  </ResponsiveContainer>
                </div>
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
};

const App = () => {
  const [coordinators, setCoordinators] = useState([]);
  const [selectedCoordinatorId, setSelectedCoordinatorId] = useState('');
  const [coordinatorLoading, setCoordinatorLoading] = useState(true);
  const [coordinatorError, setCoordinatorError] = useState(null);

  useEffect(() => {
    let cancelled = false;

    const loadCoordinators = async () => {
      setCoordinatorLoading(true);
      setCoordinatorError(null);

      try {
        const response = await fetch(buildCoordinatorApiUrl('/api/coordinators'));
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const result = await response.json();
        const nextCoordinators = result.coordinators || [];
        const defaultId = result.defaultCoordinatorId || nextCoordinators[0]?.id || '';
        const rememberedId = window.localStorage.getItem(COORDINATOR_STORAGE_KEY);
        const availableIds = new Set(nextCoordinators.map((item) => item.id));
        const nextSelectedId = availableIds.has(rememberedId) ? rememberedId : defaultId;

        if (!nextSelectedId) {
          throw new Error('No coordinators configured');
        }

        if (!cancelled) {
          setCoordinators(nextCoordinators);
          setSelectedCoordinatorId(nextSelectedId);
        }
      } catch (error) {
        if (!cancelled) {
          setCoordinatorError(error.message);
        }
      } finally {
        if (!cancelled) {
          setCoordinatorLoading(false);
        }
      }
    };

    loadCoordinators();

    return () => {
      cancelled = true;
    };
  }, []);

  const handleCoordinatorChange = (nextCoordinatorId) => {
    window.localStorage.setItem(COORDINATOR_STORAGE_KEY, nextCoordinatorId);
    startTransition(() => {
      setSelectedCoordinatorId(nextCoordinatorId);
    });
  };

  const selectedCoordinator =
    coordinators.find((coordinator) => coordinator.id === selectedCoordinatorId) || null;

  if (coordinatorLoading) {
    return (
      <div className="flex items-center justify-center h-screen bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto"></div>
          <p className="mt-4 text-gray-600">Loading coordinators...</p>
        </div>
      </div>
    );
  }

  if (coordinatorError) {
    return (
      <div className="flex items-center justify-center h-screen bg-gray-50 p-4">
        <div className="bg-red-50 border border-red-200 rounded-lg p-6 max-w-md">
          <div className="flex items-start gap-3">
            <AlertCircle className="text-red-600 mt-0.5 flex-shrink-0" size={24} />
            <div>
              <h3 className="text-red-800 font-semibold mb-2">Failed to load coordinators</h3>
              <p className="text-red-700 text-sm mb-3">{coordinatorError}</p>
              <button
                onClick={() => window.location.reload()}
                className="px-4 py-2 bg-red-600 text-white rounded-md text-sm hover:bg-red-700 transition-colors"
              >
                Retry
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <BrowserRouter>
      <Navigation
        coordinators={coordinators}
        selectedCoordinatorId={selectedCoordinatorId}
        onCoordinatorChange={handleCoordinatorChange}
        loading={coordinatorLoading}
      />
      <div className="pt-16 sm:pt-20">
        <Routes>
          <Route path="/" element={<AnalyticsDashboard key={selectedCoordinatorId} selectedCoordinatorId={selectedCoordinatorId} />} />
          <Route
            path="/offers"
            element={
              <OffersPage
                key={selectedCoordinatorId}
                selectedCoordinatorId={selectedCoordinatorId}
                selectedCoordinatorIconUrl={selectedCoordinator?.iconUrl || null}
                selectedCoordinatorFlowId={selectedCoordinator?.flowId || null}
              />
            }
          />
          <Route
            path="/flow"
            element={
              <FlowPage
                key={selectedCoordinatorId}
                selectedCoordinatorId={selectedCoordinatorId}
                coordinators={coordinators}
              />
            }
          />
        </Routes>
      </div>
    </BrowserRouter>
  );
};

export default App;
