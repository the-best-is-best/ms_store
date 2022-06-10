import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../presentation/resources/language_manager.dart';

class AppPrefs {
  static const String onBoarding = "onBoarding";

  static const String settings = "settings";

  static Future<bool> getOnBoarding(Box boarding) async =>
      await boarding.get("boarding", defaultValue: false);

  static Future<void> updateOnBoarding(Box boarding) async =>
      await boarding.put("boarding", true);

  static Future<String?> getLanguage(Box settings) async =>
      await settings.get("language");

  static Future<void> updateLanguage(
          Box settings, LangType newLanguage) async =>
      await settings.put("language", newLanguage);

  static Future<bool> getThemeMode(Box settings) async =>
      await settings.get("isDark", defaultValue: false);

  static Future<void> updateThemeMode(Box settings) async =>
      await settings.put("isDark", Get.isDarkMode ? false : true);
}
