import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/domain/models/users_model.dart';
import 'package:ms_store/domain/use_case/cache/cache_use_case.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';
import 'package:ms_store/presentation/on_boarding/view/on_boarding_view.dart';

import '../../../app/app_refs.dart';
import '../../../app/di.dart';
import '../../main/main_view.dart';

class SplashController extends GetxController {
  final CacheUserCase _cacheUserCase;
  RxBool loaded = false.obs;

  SplashController(this._cacheUserCase);

  Widget? nextPage;
  @override
  void onReady() async {
    bool? isDark = await AppPrefs().getThemeMode();
    if (isDark == null) {
      Get.changeThemeMode(ThemeMode.system);
    } else {
      if (isDark == true) {
        Get.changeThemeMode(ThemeMode.dark);
      } else {
        Get.changeThemeMode(ThemeMode.light);
      }
    }
    String? language = await AppPrefs().getLanguage();
    if (language != null) {
      Get.updateLocale(Locale(language));
    }
    String cacheKey = await AppPrefs().getCacheDataServer();
    var result = await _cacheUserCase.execute(null);
    result.fold((failure) async {
      await AppPrefs().clearCacheData();
    }, (data) async {
      if (data.data.cacheKeyServer != cacheKey) {
        await AppPrefs().clearCacheData();
        await AppPrefs().setCacheDataServer(data.data.cacheKeyServer);
      }
    });
    Future<bool> showedOnBoarding = AppPrefs().getOnBoarding();
    showedOnBoarding.then((bool value) async {
      if (value) {
        AppPrefs().closeOnBoarding();
        await initHomeModel();
        nextPage = const MainView();
        return;
      }
    });
    loaded.value = true;
    nextPage = const OnBoardingView();

    super.onReady();
  }

  @override
  void onClose() async {
    instance.unregister<CacheUserCase>();

    super.onClose();
    UserModel? userModel = await AppPrefs().getUserData();
    if (userModel != null) {
      FavController favController = Get.find();
      favController.getFavorite();
    }
  }
}
