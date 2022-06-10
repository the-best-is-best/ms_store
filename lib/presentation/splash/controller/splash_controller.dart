import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_refs.dart';
import '../../../app/di.dart';

class SplashController extends GetxController {
  RxBool loaded = false.obs;
  @override
  void onInit() async {
    bool isDark = await AppPrefs.getThemeMode(settings);
    if (isDark) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    String? langauage = await AppPrefs.getLanguage(settings);
    if (langauage != null) {
      Get.updateLocale(Locale(langauage));
    }
    super.onInit();
  }

  @override
  void onReady() async {
    loaded.value = true;
    super.onReady();
  }
}
