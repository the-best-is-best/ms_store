import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/di.dart';
import 'package:ms_store/gen/assets.gen.dart';
import '../on_boarding/view/on_boarding_view.dart';
import 'controller/splash_controller.dart';
import '../../../core/resources/color_manager.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _splashController =
      Get.put(SplashController(instance()));
  @override
  Widget build(BuildContext context) {
    return Obx((() => SplashScreenView(
          navigateWhere: _splashController.loaded.value,
          backgroundColor: ColorManager.primaryColor,
          imageSrc: const $AssetsImagesGen().logoInLight.keyName,
          duration: const Duration(milliseconds: 750),
          text: WavyAnimatedText(
            "MS Store",
            textStyle: TextStyle(
              color: ColorManager.textColor,
              fontSize: 32.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          navigateRoute: _splashController.nextPage ?? const OnBoardingView(),
        )));
  }
}
