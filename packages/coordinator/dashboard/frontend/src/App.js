import React, { useState, useEffect } from 'react';
import { BrowserRouter, Routes, Route, Link, useLocation } from 'react-router-dom';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { Calendar, TrendingUp, DollarSign, AlertCircle, Clock, Bitcoin, List, BarChart3 } from 'lucide-react';
import './App.css';
import OffersPage from './pages/OffersPage';

const Navigation = () => {
  const location = useLocation();

  return (
    <nav className="fixed top-4 left-1/2 -translate-x-1/2 z-50">
      <div className="bg-white/90 backdrop-blur-sm rounded-full shadow-lg border border-gray-200 px-2 py-1.5 flex gap-1">
        <Link
          to="/"
          className={`flex items-center gap-1.5 px-4 py-2 rounded-full text-sm font-medium transition-all ${
            location.pathname === '/'
              ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
              : 'text-gray-600 hover:bg-gray-100'
          }`}
        >
          <BarChart3 size={16} />
          Analytics
        </Link>
        <Link
          to="/offers"
          className={`flex items-center gap-1.5 px-4 py-2 rounded-full text-sm font-medium transition-all ${
            location.pathname === '/offers'
              ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
              : 'text-gray-600 hover:bg-gray-100'
          }`}
        >
          <List size={16} />
          Offers
        </Link>
      </div>
    </nav>
  );
};

const AnalyticsDashboard = () => {
  const [data, setData] = useState([]);
  const [totals, setTotals] = useState(null);
  const [takerDomainRanking, setTakerDomainRanking] = useState([]);
  const [weekdaySuccess, setWeekdaySuccess] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [groupBy, setGroupBy] = useState('daily');
  const [btcPlnRate, setBtcPlnRate] = useState(null);
  const [rateLoading, setRateLoading] = useState(true);
  const [rateError, setRateError] = useState(null);
  const [lastRateFetchTime, setLastRateFetchTime] = useState(null);

  // Exchange rate sources configuration (matching coordinator)
  const exchangeRateSources = [
    {
      name: 'CoinGecko',
      url: 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=pln',
      parser: (data) => data?.bitcoin?.pln,
    },
    {
      name: 'Yadio',
      url: 'https://api.yadio.io/exrates/pln',
      parser: (data) => data?.BTC,
    },
    {
      name: 'Blockchain.info',
      url: 'https://blockchain.info/ticker',
      parser: (data) => data?.PLN?.last,
    },
  ];

  // Fetch BTC/PLN rate from all sources and calculate average
  const fetchBtcPlnRate = async () => {
    setRateLoading(true);
    setRateError(null);

    try {
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
            console.log(`Fetched rate from ${source.name}: ${rate} PLN/BTC`);
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
        setBtcPlnRate(averageRate);
        setLastRateFetchTime(new Date());
        console.log(`Average BTC/PLN rate: ${averageRate} (from ${validRates.length} sources)`);
      } else {
        throw new Error('Failed to fetch BTC/PLN rate from all sources');
      }
    } catch (err) {
      console.error('Error fetching BTC/PLN rate:', err);
      setRateError(err.message);
    } finally {
      setRateLoading(false);
    }
  };

  // Fetch rate on component mount
  useEffect(() => {
    fetchBtcPlnRate();
    // Refresh rate every 5 minutes (matching coordinator cache time)
    const interval = setInterval(fetchBtcPlnRate, 5 * 60 * 1000);
    return () => clearInterval(interval);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Fetch data from API
  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      setError(null);

      try {
        // Send only the groupBy parameter - backend handles SQL construction
        const apiBase = process.env.REACT_APP_API_BASE || `${window.location.protocol}//${window.location.host}`;
        const response = await fetch(`${apiBase}/api/offers-data`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ groupBy })
        });

        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }

        const result = await response.json();
        setData(result.rows || []);
        setTotals(result.totals || null);
        setTakerDomainRanking(result.takerDomainRanking || []);
        setWeekdaySuccess(
          (result.weekdaySuccess || []).map((item) => ({
            ...item,
            success_count: parseInt(item.success_count || 0, 10),
            avg_offer_count: parseFloat(item.avg_offer_count || 0),
          }))
        );
      } catch (err) {
        setError(err.message);
        console.error('Error fetching data:', err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [groupBy]);

  const formatCurrency = (value) => {
    return new Intl.NumberFormat('pl-PL', {
      style: 'currency',
      currency: 'PLN',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0,
    }).format(value);
  };

  const formatNumber = (value) => {
    return new Intl.NumberFormat('en-US').format(value);
  };

  const formatCurrencyChart = (value) => {
    return new Intl.NumberFormat('pl-PL', {
      style: 'currency',
      currency: 'PLN',
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

  // Convert sats to PLN using the fetched rate
  const satsToPln = (sats) => {
    if (!btcPlnRate || !sats) return 0;
    const btc = sats / 100000000; // Convert sats to BTC
    return btc * btcPlnRate;
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

  // Calculate profit in PLN
  const totalProfitPln = satsToPln(stats.totalProfitSats);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50 p-6">
      <div className="max-w-7xl mx-auto">
        {/* Ultra-Compact Single-Line Header */}
        <div className="mb-4 relative">
          <div className="absolute inset-0 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-lg blur-2xl opacity-10"></div>
          <div className="relative backdrop-blur-sm bg-white/80 rounded-lg shadow-lg border border-white/20 px-4 py-3">
            <div className="flex items-center gap-3">
              {/* Title - Ultra Compact */}
              <div className="flex items-center gap-2">
                <TrendingUp size={18} className="text-blue-600 flex-shrink-0" />
                <h1 className="text-lg font-extrabold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent whitespace-nowrap">
                  Offers Analytics
                </h1>
              </div>
              
              {/* Flexible Spacer */}
              <div className="flex-1"></div>
              
              {/* BTC Rate - Inline */}
              <div className="flex flex-col items-center bg-amber-50 rounded px-2.5 py-1.5 border border-amber-200">
                <div className="flex items-center gap-1.5">
                  <Bitcoin size={14} className="text-amber-600 flex-shrink-0" />
                  <span className="text-xs font-semibold text-amber-700 whitespace-nowrap">
                    {rateLoading ? 'Loading...' : rateError ? 'Error' : formatCurrency(btcPlnRate)}
                  </span>
                </div>
                {!rateLoading && !rateError && lastRateFetchTime && (
                  <span className="text-[9px] text-amber-500/70 leading-none mt-0.5">
                    {formatRateTime(lastRateFetchTime)}
                  </span>
                )}
              </div>
              
              {/* Separator */}
              <div className="h-6 w-px bg-gray-300"></div>
              
              {/* Period Selector - Compact Pills */}
              <div className="flex items-center gap-1.5 bg-blue-50 rounded px-2.5 py-1.5 border border-blue-200">
                <Calendar size={14} className="text-blue-600 flex-shrink-0" />
                {['daily', 'weekly', 'monthly'].map((period) => (
                  <button
                    key={period}
                    onClick={() => setGroupBy(period)}
                    className={`px-2.5 py-1 rounded text-xs font-bold uppercase transition-all ${
                      groupBy === period
                        ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
                        : 'bg-white text-gray-600 hover:bg-gray-100'
                    }`}
                  >
                    {period[0]}
                  </button>
                ))}
              </div>
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
            <div className="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
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
                        <p className="text-2xl font-extrabold bg-gradient-to-r from-emerald-600 to-green-600 bg-clip-text text-transparent truncate leading-tight">
                          {formatNumber(stats.totalVolumeSats)}
                        </p>
                        <span className="text-sm font-medium text-green-600">sats</span>
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
                        {btcPlnRate && !rateLoading && (
                          <span className="text-xs font-semibold text-indigo-500">
                            ≈ {formatCurrency(totalProfitPln)}
                          </span>
                        )}
                      </div>
                      <div className="flex items-baseline gap-1.5">
                        <p className="text-2xl font-extrabold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent truncate leading-tight">
                          {formatNumber(stats.totalProfitSats)}
                        </p>
                        <span className="text-sm font-medium text-blue-600">sats</span>
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
                      <p className="text-2xl font-extrabold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
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
                      <p className="text-2xl font-extrabold bg-gradient-to-r from-amber-600 to-orange-600 bg-clip-text text-transparent">
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
                      <p className="text-2xl font-extrabold bg-gradient-to-r from-cyan-600 to-blue-600 bg-clip-text text-transparent">
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
                      <p className="text-2xl font-extrabold bg-gradient-to-r from-teal-600 to-emerald-600 bg-clip-text text-transparent">
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
                        <p className="text-2xl font-extrabold bg-gradient-to-r from-rose-600 to-pink-600 bg-clip-text text-transparent truncate leading-tight">
                          {formatNumber(stats.avgTakerInvoiceFees)}
                        </p>
                        <span className="text-sm font-medium text-rose-600">sats</span>
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
                      <p className="text-2xl font-extrabold bg-gradient-to-r from-violet-600 to-purple-600 bg-clip-text text-transparent">
                        {stats.takerFeesPercentage?.toFixed(2)}%
                      </p>
                    </div>
                  </div>
                  <div className="mt-2 h-0.5 bg-gradient-to-r from-violet-400 to-purple-600 rounded-full"></div>
                </div>
              </div>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
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
                  Volume (PLN)
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

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
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
                  Profit Trend (Sats & PLN)
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <LineChart data={data.map(d => ({
                    ...d,
                    profit_pln: satsToPln(parseFloat(d.profit || 0))
                  }))}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis dataKey="date" angle={-45} textAnchor="end" height={80} tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis yAxisId="left" tick={{ fill: '#6b7280', fontSize: 12 }} label={{ value: 'Sats', angle: -90, position: 'insideLeft', style: { fill: '#f59e0b' } }} />
                    <YAxis yAxisId="right" orientation="right" tick={{ fill: '#6b7280', fontSize: 12 }} tickFormatter={(value) => value.toFixed(2)} label={{ value: 'PLN', angle: 90, position: 'insideRight', style: { fill: '#10b981' } }} />
                    <Tooltip
                      formatter={(value, name) => {
                        if (name === 'Profit (PLN)') return [formatCurrencyChart(value), name];
                        return [formatNumber(value) + ' sats', name];
                      }}
                      contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }}
                    />
                    <Legend />
                    <Line yAxisId="left" type="monotone" dataKey="profit" stroke="#f59e0b" strokeWidth={2} name="Profit (Sats)" dot={{ fill: '#f59e0b', r: 4 }} />
                    <Line yAxisId="right" type="monotone" dataKey="profit_pln" stroke="#10b981" strokeWidth={2} name="Profit (PLN)" dot={{ fill: '#10b981', r: 4 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
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

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
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

            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
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

              <div className="bg-white rounded-xl shadow-lg hover:shadow-xl transition-shadow duration-300 border border-gray-200 p-6 card-shine">
                <h3 className="text-lg font-bold text-gray-900 mb-4 flex items-center gap-2">
                  <div className="h-2 w-2 rounded-full bg-indigo-500"></div>
                  Taker Domain Ranking (Total)
                </h3>
                <ResponsiveContainer width="100%" height={300}>
                  <BarChart data={takerDomainRanking} layout="vertical">
                    <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                    <XAxis type="number" tick={{ fill: '#6b7280', fontSize: 12 }} />
                    <YAxis dataKey="taker_domain" type="category" width={120} tick={{ fill: '#6b7280', fontSize: 11 }} />
                    <Tooltip formatter={(value) => `${value}%`} contentStyle={{ backgroundColor: '#fff', border: '1px solid #e5e7eb', borderRadius: '8px' }} />
                    <Legend />
                    <Bar dataKey="avg_fees_percentage" fill="#6366f1" name="Avg Fees %" />
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </div>
          </>
        )}
      </div>
    </div>
  );
};

const App = () => {
  return (
    <BrowserRouter>
      <Navigation />
      <div className="pt-16">
        <Routes>
          <Route path="/" element={<AnalyticsDashboard />} />
          <Route path="/offers" element={<OffersPage />} />
        </Routes>
      </div>
    </BrowserRouter>
  );
};

export default App;
