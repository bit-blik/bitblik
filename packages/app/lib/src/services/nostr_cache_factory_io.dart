import 'package:ndk_objectbox/data_layer/db/object_box/db_object_box.dart';

Future<DbObjectBox>? _cacheManagerFuture;

Future<dynamic> createNostrCacheManager() =>
    _cacheManagerFuture ??= Future.value(DbObjectBox());
