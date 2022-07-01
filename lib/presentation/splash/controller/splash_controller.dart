import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/domain/use_case/cache/cache_use_case.dart';
import 'package:ms_store/presentation/on_boarding/view/on_boarding_view.dart';
import '../../../app/app_refs.dart';
import '../../../app/di.dart';
import '../../base/user_data/user_data_controller.dart';
import '../../main/main_view.dart';
import '../../main/pages/home/view_model/home_controller.dart';

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
        if (nextPage.runtimeType == MainView) {
          UserDataController userDataController = Get.find();
          await userDataController.getUserData();
          HomeController homeController = Get.find();
          homeController.getHomeData();

          return;
        }
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
  }
}
