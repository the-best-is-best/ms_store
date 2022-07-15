import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/font_manger.dart';

import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
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
    final String lang = Get.locale!.languageCode;

    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          Get.defaultDialog(
              barrierDismissible: false,
              title: AppStrings.closeAppTitle,
              titleStyle: context.textTheme.titleLarge,
              textCancel: AppStrings.no,
              cancelTextColor: Colors.black,
              buttonColor: ColorManager.darkColor,
              textConfirm: AppStrings.yes,
              confirmTextColor: ColorManager.white,
              onConfirm: () {
                exit(1);
              },
              backgroundColor: ColorManager.white,
              middleText: AppStrings.closeAppMessage);
          return false;
        },
        child: Scaffold(
          body: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _mainController.opacity.value,
            child: Obx(() => _mainController
                .pages[_mainController.currentIndex.value]!['page']),
          ),
          bottomNavigationBar: Container(
              height: lang == "ar" ? 90.h : 80.h,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87, spreadRadius: AppSpacing.ap1_5)
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _mainController.currentIndex.value,
                onTap: onTap,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconsManger.home,
                        size: FontSize.s24,
                      ),
                      label: AppStrings.homeTitle),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconsManger.category,
                        size: FontSize.s24,
                      ),
                      label: AppStrings.categoryTitle),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconsManger.cart,
                        size: FontSize.s24,
                      ),
                      label: AppStrings.cartTitle),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconsManger.heart,
                        size: FontSize.s24,
                      ),
                      label: AppStrings.favTitle),
                  BottomNavigationBarItem(
                      icon: Icon(
                        IconsManger.settings,
                        size: FontSize.s24,
                      ),
                      label: AppStrings.setting),
                ],
              )),
        ),
      ),
    );
  }

  void onTap(int index) {
    _mainController.changeCurrentIndex(index);
  }
}
