import 'package:hive/hive.dart';
part 'cache_data.g.dart';

@HiveType(typeId: 7)
class CachedData<T> {
  @HiveField(0)
  final T data;
  @HiveField(1)
  final int cacheTime;
  CachedData(this.data, this.cacheTime);
}
