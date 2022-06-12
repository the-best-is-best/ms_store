import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ms_store/domain/models/users_model.dart';
import '../domain/models/cache/cache_data.dart';
import 'extensions.dart';

class AppPrefs {
  static late final Box _onBoardingBox;
  static const String _onBoardingBoxName = "onBoarding";
  static const String _onBoardingKey = "onBoarding";

  static late final Box _settingsBox;
  static const String _settingsBoxName = "settings";
  static const String _settingsLanguageKey = "language";
  static const String _settingsIsDarkKey = "isDark";

  static late final Box _cacheDataBox;
  static const String _cacheDataBoxName = "cacheData";
  static const String _cacheDataUserKey = "userData";

  static Future checkBox() async {
    _settingsBox = await Hive.openBox(_settingsBoxName);
    _onBoardingBox = await Hive.openBox(_onBoardingBoxName);
    _cacheDataBox = await Hive.openBox(_cacheDataBoxName);
  }

//_onBoardingBox

  static void closeOnBoarding() {
    if (_onBoardingBox.isOpen) {
      _onBoardingBox.close();
    }
  }

  static Future<bool> getOnBoarding() async =>
      await _onBoardingBox.get(_onBoardingKey, defaultValue: false);

  static Future<void> updateOnBoarding() async =>
      await _onBoardingBox.put(_onBoardingKey, true);

//_settingsBox
  static Future<String?> getLanguage() async =>
      await _settingsBox.get(_settingsLanguageKey);

  static Future<void> updateLanguage(
          Box settings, LangType newLanguage) async =>
      await _settingsBox.put(_settingsLanguageKey, newLanguage);

  static Future<bool?> getThemeMode() async =>
      await _settingsBox.get(_settingsIsDarkKey);

  static Future<void> updateThemeMode() async =>
      await _settingsBox.put(_settingsIsDarkKey, Get.isDarkMode ? false : true);

  // cache data
  static Future<CachedData?> getCacheData(String key) async {
    return await _cacheDataBox.get(key);
  }
  // users

  static Future<void> updateUserData(UserModel data) async =>
      await _cacheDataBox.put(_cacheDataUserKey, data);

//home
  static Future<void> updateCacheData<T>(String key, T data) async =>
      await _cacheDataBox.put(key, data);

  static Future<void> clearByKeyCacheData(String key) async =>
      await _cacheDataBox.delete(key);
}
