import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ms_store/domain/models/users_model.dart';
import '../domain/models/cache/cache_data.dart';
import 'extensions.dart';

class AppPrefs with OnBoardingAppPrefs, SettingsAppPrefs, UserAppPrefs {
  static late final Box _cacheDataBox;
  static const String _cacheDataBoxName = "cacheData";
  AppPrefs._internal(); // singleton or single instance
  static final AppPrefs _instance = AppPrefs._internal();
  factory AppPrefs() => _instance; // factory
  Future initBox() async {
    await initBoardingBox();
    await initSettingBox();
    await initUserBox();
    _cacheDataBox = await Hive.openBox(_cacheDataBoxName);
  }

  // cache data
  Future<CachedData?> getCacheData(String key) async {
    return await _cacheDataBox.get(key);
  }

//home
  Future<void> updateCacheData<T>(String key, T data) async =>
      await _cacheDataBox.put(key, data);

  Future<void> clearByKeyCacheData(String key) async =>
      await _cacheDataBox.delete(key);
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
    _userData = await Hive.openBox('userData');
  } // users

  Future<void> updateUserData(UserModel data) async =>
      await _userData.put('userData', data);

  Future<UserModel?> getUserData() async => await _userData.get('userData');
}
