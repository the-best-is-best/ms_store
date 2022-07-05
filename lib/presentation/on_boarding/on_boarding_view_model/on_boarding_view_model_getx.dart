import 'package:get/get.dart';
import 'package:ms_store/gen/assets.gen.dart';

import '../../../app/app_refs.dart';
import '../../../domain/models/on_boarding_model.dart';
import '../../../app/resources/strings_manager.dart';

class OnBoardingController extends GetxController with DataScreen {
  @override
  void onInit() {
    super.onInit();

    super.pageViewData.value = super._getSliderData();
  }

  @override
  void onClose() async {
    AppPrefs().updateOnBoarding();
    super.onClose();
  }
}

mixin DataScreen {
  RxList<OnBoarding?> pageViewData = <OnBoarding?>[].obs;
  List<OnBoarding> _getSliderData() {
    return [
      OnBoarding(
          title: AppStrings.onBoardingTitle1,
          description: AppStrings.onBoardingDescription1,
          urlImage: const $AssetsImagesGen().onboard1.path),
      OnBoarding(
          title: AppStrings.onBoardingTitle2,
          description: AppStrings.onBoardingDescription2,
          urlImage: const $AssetsImagesGen().onboard2.path),
      OnBoarding(
          title: AppStrings.onBoardingTitle3,
          description: AppStrings.onBoardingDescription3,
          urlImage: const $AssetsImagesGen().onboard3.path),
    ];
  }
}
