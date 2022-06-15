import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';

import '../../../../../app/app_refs.dart';

class SettingsController extends GetxController {
  RxString language = 'en'.obs;
  void loadData() async {
    language.value = await AppPrefs().getLanguage() ??
        Get.deviceLocale!.languageCode.toString();

    super.onInit();
  }

  void changeLanguage(LangType lang) {
    AppPrefs().updateLanguage(lang);
    Get.updateLocale(Locale(lang.getValue()));
    language.value = lang.getValue();
    Get.back();
  }
}
