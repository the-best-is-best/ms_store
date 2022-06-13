import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/extensions.dart';
import 'package:ms_store/domain/models/users_model.dart';

import '../../../../../app/app_refs.dart';

class SettingsController extends GetxController {
  RxString language = 'en'.obs;
  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  void loadData() async {
    language.value = await AppPrefs().getLanguage() ??
        Get.deviceLocale!.languageCode.toString();

    userModel.value = await AppPrefs().getUserData();
    super.onInit();
  }

  void changeLanguage(LangType lang) {
    AppPrefs().updateLanguage(lang);
    Get.updateLocale(Locale(lang.getValue()));
    language.value = lang.getValue();
    Get.back();
  }
}
