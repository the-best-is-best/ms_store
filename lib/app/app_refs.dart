import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ms_store/domain/models/store/favorite_model.dart';
import 'package:ms_store/domain/models/users_model.dart';
import '../domain/models/cache/cache_data.dart';
import '../domain/models/home_models/category_home_model.dart';
import '../domain/models/home_models/data_home_model.dart';
import '../domain/models/home_models/home_data_model.dart';
import '../domain/models/home_models/product_home_model.dart';
import '../domain/models/home_models/slider_model.dart';
import '../domain/models/store/category_model.dart';
import 'extensions.dart';

class AppPrefs with OnBoardingAppPrefs, SettingsAppPrefs, UserAppPrefs {
  static late final Box _cacheDataServerBox;
  static const String _cacheDataServerBoxName = "cacheDataServer";
  static const String _cacheDataServerKey = "cacheKeyServer";

  static late final Box _cacheDataLocalBox;
  static const String _cacheDataLocalBoxName = "cacheData";
  AppPrefs._internal(); // singleton or single instance
  static final AppPrefs _instance = AppPrefs._internal();
  factory AppPrefs() => _instance; // factory
  Future initBox() async {
    //home
    Hive.registerAdapter(HomeModelAdapter());
    Hive.registerAdapter(HomeDataModelAdapter());
    Hive.registerAdapter(SliderModelAdapter());
    Hive.registerAdapter(CategoryHomeModelAdapter());
    Hive.registerAdapter(ProductHomeModelAdapter());
    Hive.registerAdapter(DataHomeModelAdapter());
    // category
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(CategoryDataModelAdapter());
    Hive.registerAdapter(CategoryDataWithChildModelAdapter());
// favorite cache
    Hive.registerAdapter(FavoriteDataModelAdapter());
    Hive.registerAdapter(FavoriteModelAdapter());

    // cache local
    //cacheLocal
    Hive.registerAdapter(CachedDataAdapter());
    await initBoardingBox();
    await initSettingBox();
    await initUserBox();
    _cacheDataLocalBox = await Hive.openBox(_cacheDataLocalBoxName);
    _cacheDataServerBox = await Hive.openBox(_cacheDataServerBoxName);
  }

  // cache data server
  Future<String> getCacheDataServer() async {
    return await _cacheDataServerBox.get(_cacheDataServerKey, defaultValue: "");
  }

  Future<void> setCacheDataServer(String data) async =>
      await _cacheDataServerBox.put(_cacheDataServerKey, data);

  // cache data local
  Future<CachedData?> getCacheData(String key) async {
    return await _cacheDataLocalBox.get(key);
  }

  Future<void> clearCacheData() async => await _cacheDataLocalBox.clear();
//home
  Future<void> saveCacheData(String key, CachedData data) async =>
      await _cacheDataLocalBox.put(key, data);

  Future<void> clearByKeyCacheData(String key) async =>
      await _cacheDataLocalBox.delete(key);
}

mixin OnBoardingAppPrefs {
  late final Box _onBoardingBox;
  final String _onBoardingBoxName = "onBoarding";
  final String _onBoardingKey = "onBoarding";

//_onBoardingBox
  Future initBoardingBox() async {
    _onBoardingBox = await Hive.openBox(_onBoardingBoxName);
  }

  void closeOnBoarding() {
    if (_onBoardingBox.isOpen) {
      _onBoardingBox.close();
    }
  }

  Future<bool> getOnBoarding() async =>
      await _onBoardingBox.get(_onBoardingKey, defaultValue: false);

  Future<void> updateOnBoarding() async =>
      await _onBoardingBox.put(_onBoardingKey, true);
}

mixin SettingsAppPrefs {
  late final Box _settingsBox;
  final String _settingsBoxName = "settings";
  final String _settingsLanguageKey = "language";
  final String _settingsIsDarkKey = "isDark";
  Future initSettingBox() async {
    _settingsBox = await Hive.openBox(_settingsBoxName);
  }

  String getSettingBox() {
    return _settingsBoxName;
  }

  String getSettingLanguageKey() {
    return _settingsLanguageKey;
  }

//_settingsBox
  Future<String?> getLanguage() async =>
      await _settingsBox.get(_settingsLanguageKey);

  Future<void> updateLanguage(LangType newLanguage) async =>
      await _settingsBox.put(_settingsLanguageKey, newLanguage.getValue());

  Future<bool?> getThemeMode() async =>
      await _settingsBox.get(_settingsIsDarkKey);

  Future<void> updateThemeMode() async =>
      await _settingsBox.put(_settingsIsDarkKey, Get.isDarkMode ? false : true);
}

// users Box

mixin UserAppPrefs {
  late final Box _userData;
  Future initUserBox() async {
    Hive.registerAdapter(UserModelAdapter());
    _userData = await Hive.openBox('userData');
  } // users

  Future<void> updateUserData(UserModel data) async =>
      await _userData.put('userData', data);

  Future<UserModel?> getUserData() async => await _userData.get('userData');
  Future<void> clearUserData() async => await _userData.clear();
}
