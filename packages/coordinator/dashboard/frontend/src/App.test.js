import { act, render, screen, waitFor } from '@testing-library/react';
import { AnalyticsDashboard, Navigation } from './App';

// react-scripts' Jest resolver predates react-router-dom v7's export map. The
// dashboard under test does not use routing itself, so provide the imports that
// App.js evaluates without pulling the router into this focused unit test.
jest.mock('react-router-dom', () => ({
  BrowserRouter: ({ children }) => children,
  Routes: ({ children }) => children,
  Route: () => null,
  Link: ({ children, to, ...props }) => <a href={to} {...props}>{children}</a>,
  useLocation: () => ({ pathname: global.mockRouterPathname || '/' }),
}), { virtual: true });

const originalFetch = global.fetch;

const jsonResponse = (body) => ({
  ok: true,
  json: async () => body,
});

const emptyAnalytics = (currency) => ({
  currency,
  rows: [],
  totals: {},
  weekdaySuccess: [],
  weekdayVolume: [],
  categoryDistribution: [],
  clientVersionDistribution: [],
  pagination: null,
});

test('waits for the selected coordinator currency before fetching exchange rates', async () => {
  let resolveAnalytics;
  const analyticsResponse = new Promise((resolve) => {
    resolveAnalytics = resolve;
  });

  global.fetch = jest.fn((url) => {
    if (url.includes('/api/offers-data')) return analyticsResponse;
    if (url.includes('coingecko.com')) return Promise.resolve(jsonResponse({ bitcoin: { eur: 50000 } }));
    if (url.includes('yadio.io')) return Promise.resolve(jsonResponse({ BTC: 51000 }));
    if (url.includes('blockchain.info')) return Promise.resolve(jsonResponse({ EUR: { last: 52000 } }));
    return Promise.reject(new Error(`Unexpected request: ${url}`));
  });

  render(<AnalyticsDashboard selectedCoordinatorId="eur-coordinator" />);

  expect(global.fetch).toHaveBeenCalledTimes(1);
  expect(global.fetch.mock.calls[0][0]).toContain('/api/offers-data?coordinator=eur-coordinator');

  await act(async () => {
    resolveAnalytics(jsonResponse(emptyAnalytics('EUR')));
  });

  await waitFor(() => expect(global.fetch).toHaveBeenCalledTimes(4));

  const rateUrls = global.fetch.mock.calls.slice(1).map(([url]) => url);
  expect(rateUrls).toEqual(expect.arrayContaining([
    expect.stringContaining('vs_currencies=eur'),
    expect.stringContaining('/exrates/EUR'),
    'https://blockchain.info/ticker',
  ]));
  expect(rateUrls.some((url) => /pln/i.test(url))).toBe(false);
});

test('loads all coordinators in Total analytics and defaults to the selected coordinator currency', async () => {
  global.fetch = jest.fn((url) => {
    if (url.includes('/api/offers-data')) {
      const currency = url.includes('coordinator=pln') ? 'PLN' : 'EUR';
      return Promise.resolve(jsonResponse(emptyAnalytics(currency)));
    }
    if (url.includes('coingecko.com')) {
      return Promise.resolve(jsonResponse({ bitcoin: { eur: 50000, pln: 400000 } }));
    }
    if (url.includes('yadio.io')) return Promise.resolve(jsonResponse({ BTC: 50000 }));
    if (url.includes('blockchain.info')) {
      return Promise.resolve(jsonResponse({ EUR: { last: 50000 }, PLN: { last: 400000 } }));
    }
    return Promise.reject(new Error(`Unexpected request: ${url}`));
  });

  render(
    <AnalyticsDashboard
      selectedCoordinatorId="eur"
      coordinators={[{ id: 'pln' }, { id: 'eur' }]}
      isTotal
    />
  );

  expect(await screen.findByText('Total Analytics')).toBeInTheDocument();
  expect(screen.getByLabelText('Display currency')).toHaveValue('EUR');
  await waitFor(() => expect(global.fetch).toHaveBeenCalledTimes(8));

  const analyticsUrls = global.fetch.mock.calls
    .map(([url]) => url)
    .filter((url) => url.includes('/api/offers-data'));
  expect(analyticsUrls).toEqual(expect.arrayContaining([
    expect.stringContaining('coordinator=pln'),
    expect.stringContaining('coordinator=eur'),
  ]));
});

test('shows Total with coordinator pills and disables Offers while Total is selected', () => {
  global.mockRouterPathname = '/total';

  render(
    <Navigation
      coordinators={[
        { id: 'eur', label: 'EUR coordinator' },
        { id: 'pln', label: 'PLN coordinator' },
      ]}
      selectedCoordinatorId="eur"
      onCoordinatorChange={jest.fn()}
      loading={false}
    />
  );

  expect(screen.getByText('Offers').closest('a')).toHaveAttribute('aria-disabled', 'true');
  expect(screen.getByText('Offers').closest('a')).toHaveAttribute('tabindex', '-1');
  expect(screen.getByText('Total').closest('a')).toHaveAttribute('href', '/total');
  expect(screen.getByText('EUR coordinator').closest('a')).toHaveAttribute('href', '/');
});

test('hides Total when only one coordinator is configured', () => {
  render(
    <Navigation
      coordinators={[{ id: 'only', label: 'Only coordinator' }]}
      selectedCoordinatorId="only"
      onCoordinatorChange={jest.fn()}
      loading={false}
    />
  );

  expect(screen.queryByText('Total')).not.toBeInTheDocument();
  expect(screen.getByText('Only coordinator')).toBeInTheDocument();
});

afterEach(() => {
  jest.restoreAllMocks();
  global.fetch = originalFetch;
  delete global.mockRouterPathname;
});
