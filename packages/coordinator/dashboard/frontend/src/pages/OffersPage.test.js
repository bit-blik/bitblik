import { calcProfit, calcProfitFiat } from './OffersPage';

// The API serves BIGINT/NUMERIC columns as strings, which is what these
// helpers really receive at runtime.
describe('calcProfit', () => {
  it('sums string fee columns numerically instead of concatenating them', () => {
    // Real row 79e733b2: 368 + 1080 - 15. Concatenation produced 3681065.
    expect(calcProfit('368', '1080', '15')).toBe(1433);
    // Real row e4e22d78: 555 + 1630 - 108. Concatenation produced 5551522.
    expect(calcProfit('555', '1630', '108')).toBe(2077);
  });

  it('works the same for number inputs', () => {
    expect(calcProfit(368, 1080, 15)).toBe(1433);
  });

  it('treats missing routing fees as zero and keeps null when there are no fees at all', () => {
    expect(calcProfit('368', '1080', null)).toBe(1448);
    expect(calcProfit('368', null, undefined)).toBe(368);
    expect(calcProfit(null, null, '15')).toBeNull();
  });

  it('ignores unparseable values rather than producing NaN', () => {
    expect(calcProfit('368', 'x', '15')).toBe(353);
  });
});

describe('calcProfitFiat', () => {
  it('converts a sats profit with string amount/fiat columns', () => {
    // 1433 sats of a 143945-sat trade worth 100 EUR ≈ 1.00 EUR.
    expect(calcProfitFiat(1433, '100.0', '143945')).toBeCloseTo(0.9955, 3);
  });

  it('returns null when the trade has no amount', () => {
    expect(calcProfitFiat(1433, '100.0', 0)).toBeNull();
    expect(calcProfitFiat(null, '100.0', '143945')).toBeNull();
  });
});
