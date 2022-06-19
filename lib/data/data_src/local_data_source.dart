import 'package:ms_store/app/app_refs.dart';
import 'package:ms_store/data/network/error_handler.dart';
import 'package:ms_store/domain/models/store/category_model.dart';
import 'package:ms_store/domain/models/store/product_model.dart';

import '../../domain/models/cache/cache_data.dart';
import '../../domain/models/home_models/home_data_model.dart';

const String CACHE_HOME_KEY = "CACHE_HOME";
const String CACHE_CATEGORY_KEY = "CACHE_CATEGORY";
const String CACHE_Favorite_KEY = "CACHE_FAVORITE";
const String CACHE_PRODUCT_FAVORITE_KEY = "CACHE_FAVORITE_CART";

const String CACHE_CART_KEY = "CACHE_CART";
const String CACHE_PRODUCT_CART_KEY = "CACHE_PRODUCT_CART";

abstract class LocalDataSource {
  Future<HomeModel> getHomeData();
  Future<void> saveHomeDataCache(HomeModel homeModel);

  Future<CategoryModel> getCategoryData();
  Future<void> saveCategoryDataCache(CategoryModel categoryModel);

  Future<Map<int, bool>> getFavoriteData();
  Future<List<ProductModel>> getProductFavData();
  Future<void> saveFavoriteDataCache(Map<int, bool> favoriteModel);
  Future<void> saveProductFavData(List<ProductModel> favoriteProductModel);

  Future<Map<int, int>> getCartData();
  Future<void> saveProductCartData(List<ProductModel> products);
  Future<void> saveCartDataCache(Map<int, int> cartModel);
  Future<List<ProductModel>> getProductCartData();

  Future<void> deleteProductCartData();
  Future<void> deleteCartData();
  Future<void> deleteFavData();

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
  Future<void> saveFavoriteDataCache(Map<int, bool> favoriteModel) async {
    await AppPrefs()
        .saveCacheData(CACHE_Favorite_KEY, CachedData(favoriteModel));
  }

  @override
  Future<Map<int, bool>> getFavoriteData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_Favorite_KEY);
    if (cachedData != null) {
      return (cachedData.data as Map<dynamic, dynamic>).cast<int, bool>();
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<Map<int, int>> getCartData() async {
    CachedData? cachedData = await AppPrefs().getCacheData(CACHE_CART_KEY);
    if (cachedData != null) {
      return (cachedData.data as Map<dynamic, dynamic>).cast<int, int>();
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveCartDataCache(Map<int, int> cartModel) async {
    await AppPrefs().saveCacheData(CACHE_CART_KEY, CachedData(cartModel));
  }

  @override
  Future<void> deleteCartData() async {
    await AppPrefs().clearByKeyCacheData(CACHE_CART_KEY);
  }

  @override
  Future<void> deleteFavData() async {
    await AppPrefs().clearByKeyCacheData(CACHE_Favorite_KEY);
  }

  @override
  Future<void> saveProductCartData(List<ProductModel> products) async {
    await AppPrefs()
        .saveCacheData(CACHE_PRODUCT_CART_KEY, CachedData(products));
  }

  @override
  Future<List<ProductModel>> getProductCartData() async {
    CachedData? cachedData =
        await AppPrefs().getCacheData(CACHE_PRODUCT_CART_KEY);
    if (cachedData != null) {
      return ((cachedData.data) as List<dynamic>).cast<ProductModel>();
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> deleteProductCartData() async {
    await AppPrefs().clearByKeyCacheData(CACHE_PRODUCT_CART_KEY);
  }

  @override
  Future<List<ProductModel>> getProductFavData() async {
    CachedData? cachedData =
        await AppPrefs().getCacheData(CACHE_PRODUCT_FAVORITE_KEY);
    if (cachedData != null) {
      return ((cachedData.data) as List<dynamic>).cast<ProductModel>();
    } else {
      throw ErrorHandler.handle(DataRes.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveProductFavData(
      List<ProductModel> favoriteProductModel) async {
    await AppPrefs().saveCacheData(
        CACHE_PRODUCT_FAVORITE_KEY, CachedData(favoriteProductModel));
  }
}
