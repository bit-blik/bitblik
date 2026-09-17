/// Converts native HTTP(S) app links to router-local URIs.
///
/// Nsite hosts the web app under `/app`, which is not part of the native route
/// table. On web, PathUrlStrategy already handles the HTML base href; do not
/// apply this normalization to browser navigation.
Uri normalizeAppLinkUri(Uri uri) {
  if (uri.hasScheme && uri.scheme != 'https' && uri.scheme != 'http') {
    return uri;
  }

  var path = uri.path;
  if (path == '/app') {
    path = '/';
  } else if (path.startsWith('/app/')) {
    path = path.substring('/app'.length);
  }

  // Retain support for legacy links such as /#/offers and /app/#/offers.
  if ((path.isEmpty || path == '/') && uri.fragment.startsWith('/')) {
    return Uri.parse(uri.fragment);
  }

  return Uri(
    path: path.isEmpty ? '/' : path,
    query: uri.hasQuery ? uri.query : null,
    fragment: uri.hasFragment ? uri.fragment : null,
  );
}
