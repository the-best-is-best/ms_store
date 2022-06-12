import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/font_manger.dart';

import '../../../core/resources/icons_manger.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';
import 'controller/main_view_controller.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
            height: AppSize.ap80.h,
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
                    icon: Icon(
                      IconsManger.home,
                      size: FontSize.s20,
                    ),
                    label: AppStrings.homeTitle),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconsManger.category,
                      size: FontSize.s20,
                    ),
                    label: AppStrings.categoryTitle),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconsManger.cart,
                      size: FontSize.s20,
                    ),
                    label: AppStrings.cartTitle),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconsManger.heart,
                      size: FontSize.s20,
                    ),
                    label: AppStrings.favTitle),
                BottomNavigationBarItem(
                    icon: Icon(
                      IconsManger.settings,
                      size: FontSize.s20,
                    ),
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
