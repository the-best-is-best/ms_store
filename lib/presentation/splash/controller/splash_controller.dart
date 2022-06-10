import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/home/main_view.dart';
import 'package:ms_store/presentation/on_boarding/view/on_boarding_view.dart';

import '../../../app/app_refs.dart';
import '../../../app/di.dart';
import '../../resources/routes_manger.dart';

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
    String? language = await AppPrefs.getLanguage(settings);
    if (language != null) {
      Get.updateLocale(Locale(language));
    }
    super.onInit();
  }

  Widget? nextPage;
  @override
  void onReady() async {
    Future<bool> showedOnBoarding = AppPrefs.getOnBoarding(onBoarding);
    showedOnBoarding.then((bool value) async {
      if (value) {
        await initHomeModel();
        nextPage = const HomeView();
        return;
      }
    });
    loaded.value = true;
    nextPage = const OnBoardingView();

    super.onReady();
  }
}
