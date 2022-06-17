import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/data/network/error_handler.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';

import '../../domain/models/cache/cache_data.dart';
import '../../domain/models/home_models/home_data_model.dart';

const String CACHE_HOME_KEY = "CACHE_HOME";
const String CACHE_CATEGORY_KEY = "CACHE_CATEGORY";
const String CACHE_Favorite_KEY = "CACHE_FAVORITE";

abstract class LocalDataSource {
  Future<HomeModel> getHomeData();
  Future<void> saveHomeDataCache(HomeModel homeModel);
  Future<CategoryModel> getCategoryData();
  Future<Map<int, FavoriteDataModel>> getFavoriteData();

  Future<void> saveCategoryDataCache(CategoryModel categoryModel);
  Future<void> saveFavoriteDataCache(Map<int, FavoriteDataModel> favoriteModel);

  void removeFromCacheByKey(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<HomeModel> getHomeData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_HOME_KEY);
    if (cachedData != null) {
      return (cachedData.data) as HomeModel;
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeDataCache(HomeModel homeModel) async {
    await AppPrefs().saveCacheData(CACHE_HOME_KEY, CachedData(homeModel));
  }

  @override
  void removeFromCacheByKey(String key) {
    AppPrefs().clearByKeyCacheData(key);
  }

  @override
  Future<CategoryModel> getCategoryData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_CATEGORY_KEY);
    if (cachedData != null) {
      return (cachedData.data) as CategoryModel;
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveCategoryDataCache(CategoryModel categoryModel) async {
    await AppPrefs()
        .saveCacheData(CACHE_CATEGORY_KEY, CachedData(categoryModel));
  }

  @override
  Future<void> saveFavoriteDataCache(
      Map<int, FavoriteDataModel> favoriteModel) async {
    await AppPrefs()
        .saveCacheData(CACHE_Favorite_KEY, CachedData(favoriteModel));
  }

  @override
  Future<Map<int, FavoriteDataModel>> getFavoriteData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_Favorite_KEY);
    if (cachedData != null) {
      var dataCache = cachedData.data as Map<dynamic, dynamic>;
      Map<int, FavoriteDataModel> data = {};
      dataCache.forEach((key, value) {
        data[key] = value;
      });
      return data;
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }
}
