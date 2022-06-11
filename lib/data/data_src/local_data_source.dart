import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/data/network/error_handler.dart';

import '../../domain/models/cache/cache_data.dart';
import '../../domain/models/home_models/home_data_model.dart';

const String CACHE_HOME_KEY = "CACHE_HOME";
const int CACHE_INTERVAL = 60 * 1000 * 60 * 24 * 7;

abstract class LocalDataSource {
  Future<HomeModel> getHomeData();
  Future<void> saveHomeDataCache(HomeModel homeResponse);
  void removeFromCacheByKey(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<HomeModel> getHomeData() async {
    CachedData? cachedData = await AppPrefs.getCacheData(CACHE_HOME_KEY);
    if (cachedData != null && cachedData.isValid(CACHE_INTERVAL)) {
      return (cachedData.data) as HomeModel;
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeDataCache(HomeModel homeResponse) async {
    await AppPrefs.updateCacheData<CachedData>(CACHE_HOME_KEY,
        CachedData(homeResponse, DateTime.now().millisecondsSinceEpoch));
  }

  @override
  void removeFromCacheByKey(String key) {
    AppPrefs.clearByKeyCacheData(key);
  }
}
