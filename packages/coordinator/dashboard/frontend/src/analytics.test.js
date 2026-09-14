import {
  aggregateAnalyticsResults,
  buildCoordinatorProfitSeries,
  buildCoordinatorVolumeSatsSeries,
  buildCoordinatorVolumeSeries,
} from './analytics';

const coordinatorResult = ({
  currency,
  volume,
  success,
  failed,
  avgSeconds,
  category,
}) => ({
  currency,
  rows: [{
    date: '2026-08-13',
    success,
    failed,
    success_count: success,
    success_percentage: 0,
    volume,
    volume_sats: 1000,
    profit: 10,
    avg_reserved_seconds: avgSeconds,
    avg_total_seconds: avgSeconds * 2,
    avg_taker_invoice_fees: avgSeconds,
    taker_fees_percentage: avgSeconds,
  }],
  totals: {
    total_success: success,
    total_failed: failed,
    total_volume: volume,
    total_volume_sats: 1000,
    total_profit: 10,
    overall_avg_reserved_seconds: avgSeconds,
    overall_avg_total_seconds: avgSeconds * 2,
    overall_avg_taker_invoice_fees: avgSeconds,
    overall_taker_fees_percentage: avgSeconds,
  },
  weekdaySuccess: [{ weekday: 'Thu', success_count: success, avg_offer_count: success + failed }],
  weekdayVolume: [{ weekday: 'Thu', total_volume_fiat: volume, avg_volume_fiat: volume / 2 }],
  categoryDistribution: [{ date: '2026-08-13', category, count: success, volume }],
  clientVersionDistribution: [{ date: '2026-08-13', client: 'app/1', count: success + failed }],
  pagination: { page: 0, pageSize: 30, totalPeriods: 1, hasOlder: false, hasNewer: false },
});

test('aggregates coordinators and converts their fiat values to the display currency', () => {
  const result = aggregateAnalyticsResults([
    coordinatorResult({
      currency: 'PLN',
      volume: 400,
      success: 1,
      failed: 1,
      avgSeconds: 10,
      category: 'atm',
    }),
    coordinatorResult({
      currency: 'EUR',
      volume: 100,
      success: 3,
      failed: 1,
      avgSeconds: 30,
      category: 'atm',
    }),
  ], 'EUR', { PLN: 400000, EUR: 50000 });

  expect(result.currency).toBe('EUR');
  expect(result.totals.total_volume).toBe(150);
  expect(result.totals.total_success).toBe(4);
  expect(result.totals.total_failed).toBe(2);
  expect(result.totals.overall_success_percentage).toBeCloseTo(66.67, 1);
  expect(result.totals.overall_avg_reserved_seconds).toBe(25);
  expect(result.rows[0]).toMatchObject({
    volume: 150,
    volume_sats: 2000,
    profit: 20,
    success: 4,
    failed: 2,
    avg_reserved_seconds: 25,
  });
  expect(result.weekdayVolume[0]).toMatchObject({
    weekday: 'Thu',
    total_volume_fiat: 150,
    avg_volume_fiat: 75,
  });
  expect(result.categoryDistribution[0]).toMatchObject({
    category: 'atm',
    count: 4,
    volume: 150,
  });
  expect(result.clientVersionDistribution[0].count).toBe(6);
});

test('builds stacked volume data with one converted series per coordinator', () => {
  const pln = coordinatorResult({
    currency: 'PLN',
    volume: 400,
    success: 1,
    failed: 0,
    avgSeconds: 10,
    category: 'atm',
  });
  pln.rows.push({ date: '2026-08-14', volume: 800, volume_sats: 2000 });

  const eur = coordinatorResult({
    currency: 'EUR',
    volume: 100,
    success: 1,
    failed: 0,
    avgSeconds: 10,
    category: 'shop',
  });

  const result = buildCoordinatorVolumeSeries(
    [pln, eur],
    [
      { id: 'poland', label: 'Poland', color: '#7B2D9B' },
      { id: 'eurozone', label: 'Eurozone', color: '#0F9FAE' },
    ],
    'EUR',
    { PLN: 400000, EUR: 50000 }
  );

  expect(result.series).toEqual([
    { dataKey: 'coordinatorVolume0', id: 'poland', name: 'Poland', color: '#7B2D9B', total: 150 },
    { dataKey: 'coordinatorVolume1', id: 'eurozone', name: 'Eurozone', color: '#0F9FAE', total: 100 },
  ]);
  expect(result.data).toEqual([
    { date: '2026-08-13', coordinatorVolume0: 50, coordinatorVolume1: 100 },
    { date: '2026-08-14', coordinatorVolume0: 100, coordinatorVolume1: 0 },
  ]);

  const satsResult = buildCoordinatorVolumeSatsSeries(
    [pln, eur],
    [
      { id: 'poland', label: 'Poland', color: '#7B2D9B' },
      { id: 'eurozone', label: 'Eurozone', color: '#0F9FAE' },
    ]
  );
  expect(satsResult.series).toEqual([
    { dataKey: 'coordinatorVolumeSats0', id: 'poland', name: 'Poland', color: '#7B2D9B', total: 3000 },
    { dataKey: 'coordinatorVolumeSats1', id: 'eurozone', name: 'Eurozone', color: '#0F9FAE', total: 1000 },
  ]);
  expect(satsResult.data).toEqual([
    { date: '2026-08-13', coordinatorVolumeSats0: 1000, coordinatorVolumeSats1: 1000 },
    { date: '2026-08-14', coordinatorVolumeSats0: 2000, coordinatorVolumeSats1: 0 },
  ]);
});

test('builds stacked profit data in sats for each coordinator', () => {
  const first = coordinatorResult({
    currency: 'PLN', volume: 400, success: 1, failed: 0, avgSeconds: 10, category: 'atm',
  });
  const second = coordinatorResult({
    currency: 'EUR', volume: 100, success: 1, failed: 0, avgSeconds: 10, category: 'shop',
  });
  second.rows[0].profit = 25;

  const result = buildCoordinatorProfitSeries(
    [first, second],
    [{ id: 'first', label: 'First' }, { id: 'second', label: 'Second' }]
  );

  expect(result.series).toEqual([
    { dataKey: 'coordinatorProfit0', id: 'first', name: 'First', total: 10 },
    { dataKey: 'coordinatorProfit1', id: 'second', name: 'Second', total: 25 },
  ]);
  expect(result.data).toEqual([
    { date: '2026-08-13', coordinatorProfit0: 10, coordinatorProfit1: 25 },
  ]);
});
