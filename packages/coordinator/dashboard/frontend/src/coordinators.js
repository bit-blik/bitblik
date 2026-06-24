export const COORDINATOR_STORAGE_KEY = 'dashboard:selected-coordinator';

export const getApiBase = () =>
  process.env.REACT_APP_API_BASE || `${window.location.protocol}//${window.location.host}`;

export const buildCoordinatorApiUrl = (pathname, coordinatorId) => {
  const url = new URL(pathname, getApiBase());
  if (coordinatorId) {
    url.searchParams.set('coordinator', coordinatorId);
  }
  return url.toString();
};

export const getWebSocketBase = () => {
  const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
  const host = window.location.host;
  return process.env.REACT_APP_WS_URL || `${protocol}//${host}/ws/offers`;
};

export const buildCoordinatorWebSocketUrl = (coordinatorId) => {
  const url = new URL(getWebSocketBase(), window.location.origin);
  if (coordinatorId) {
    url.searchParams.set('coordinator', coordinatorId);
  }
  return url.toString();
};
