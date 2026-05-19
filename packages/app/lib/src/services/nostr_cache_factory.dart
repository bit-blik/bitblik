import 'nostr_cache_factory_web.dart'
    if (dart.library.io) 'nostr_cache_factory_io.dart'
    as impl;

Future<dynamic> createNostrCacheManager() => impl.createNostrCacheManager();
