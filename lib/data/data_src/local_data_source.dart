import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/data/network/error_handler.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';

import '../../domain/models/cache/cache_data.dart';
import '../../domain/models/home_models/home_data_model.dart';

const String CACHE_HOME_KEY = "CACHE_HOME";
const String CACHE_CATEGORY_KEY = "CACHE_CATEGORY";
const String CACHE_Favorite_KEY = "CACHE_CATEGORY";

const int CACHE_INTERVAL = 60 * 1000 * 60 * 24 * 7;

abstract class LocalDataSource {
  Future<HomeModel> getHomeData();
  Future<void> saveHomeDataCache(HomeModel homeModel);
  Future<CategoryModel> getCategoryData();
  Future<FavoriteModel> getFavoriteData();

  Future<void> saveCategoryDataCache(CategoryModel categoryModel);
  Future<void> saveFavoriteDataCache(FavoriteModel favoriteModel);

  void removeFromCacheByKey(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<HomeModel> getHomeData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_HOME_KEY);
    if (cachedData != null && cachedData.isValid(CACHE_INTERVAL)) {
      return (cachedData.data) as HomeModel;
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeDataCache(HomeModel homeModel) async {
    await AppPrefs().updateCacheData<CachedData>(CACHE_HOME_KEY,
        CachedData(homeModel, DateTime.now().millisecondsSinceEpoch));
  }

  @override
  void removeFromCacheByKey(String key) {
    AppPrefs().clearByKeyCacheData(key);
  }

  @override
  Future<CategoryModel> getCategoryData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_CATEGORY_KEY);
    if (cachedData != null && cachedData.isValid(CACHE_INTERVAL)) {
      return (cachedData.data) as CategoryModel;
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveCategoryDataCache(CategoryModel categoryModel) async {
    await AppPrefs().updateCacheData<CachedData>(CACHE_CATEGORY_KEY,
        CachedData(categoryModel, DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Future<void> saveFavoriteDataCache(FavoriteModel favoriteModel) async {
    await AppPrefs().updateCacheData<CachedData>(CACHE_Favorite_KEY,
        CachedData(favoriteModel, DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Future<FavoriteModel> getFavoriteData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_Favorite_KEY);
    if (cachedData != null && cachedData.isValid(CACHE_INTERVAL)) {
      return (cachedData.data) as FavoriteModel;
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }
}
