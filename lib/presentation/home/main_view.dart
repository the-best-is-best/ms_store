import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../resources/icons_manger.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'controller/main_view_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final MainViewController _mainController;
  @override
  void initState() {
    _mainController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: _mainController.opacity.value,
          child: Obx(() => _mainController
              .pages[_mainController.currentIndex.value]!['page']),
        ),
        bottomNavigationBar: Container(
            height: AppSize.s80.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black87, spreadRadius: AppSpacing.ap1_5.w)
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: _mainController.currentIndex.value,
              onTap: onTap,
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(IconsManger.home),
                    label: AppStrings.homeTitle),
                BottomNavigationBarItem(
                    icon: const Icon(IconsManger.category),
                    label: AppStrings.categoryTitle),
                BottomNavigationBarItem(
                    icon: const Icon(IconsManger.cart),
                    label: AppStrings.cartTitle),
                BottomNavigationBarItem(
                    icon: const Icon(IconsManger.heart),
                    label: AppStrings.favTitle),
                BottomNavigationBarItem(
                    icon: const Icon(IconsManger.settings),
                    label: AppStrings.setting),
              ],
            )),
      ),
    );
  }

  void onTap(int index) {
    _mainController.changeCurrentIndex(index);
  }
}
