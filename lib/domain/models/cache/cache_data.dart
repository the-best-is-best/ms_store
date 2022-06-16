import 'package:hive/hive.dart';
part 'cache_data.g.dart';

@HiveType(typeId: 7)
class CachedData {
  @HiveField(0)
  final dynamic data;
  @HiveField(1)
  CachedData(this.data);
}

class CheckCachedDataServer {
  final CheckCachedServer data;
  CheckCachedDataServer(this.data);
}

class CheckCachedServer {
  final String cacheKeyServer;
  CheckCachedServer(this.cacheKeyServer);
}
