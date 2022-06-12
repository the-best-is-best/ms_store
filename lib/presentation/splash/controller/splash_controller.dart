import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/on_boarding/view/on_boarding_view.dart';

import '../../../app/app_refs.dart';
import '../../../app/di.dart';
import '../../main/main_view.dart';

class SplashController extends GetxController {
  RxBool loaded = false.obs;
  @override
  void onInit() async {
    bool? isDark = await AppPrefs.getThemeMode();
    if (isDark == null) {
      Get.changeThemeMode(ThemeMode.system);
    } else {
      if (isDark == true) {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
    }
    String? language = await AppPrefs.getLanguage();
    if (language != null) {
      Get.updateLocale(Locale(language));
    }
    super.onInit();
  }

  Widget? nextPage;
  @override
  void onReady() async {
    Future<bool> showedOnBoarding = AppPrefs.getOnBoarding();
    showedOnBoarding.then((bool value) async {
      if (value) {
        AppPrefs.closeOnBoarding();
        await initHomeModel();
        nextPage = const MainView();
        return;
      }
    });
    loaded.value = true;
    nextPage = const OnBoardingView();

    super.onReady();
  }
}
