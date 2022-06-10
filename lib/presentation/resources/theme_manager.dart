import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'font_manger.dart';
import 'styles_manger.dart';
import 'values_manager.dart';

ThemeData get themeDataLight {
  return ThemeData(
    // main color
    primaryColor: ColorManager.primaryColorLight,
    primaryColorLight: ColorManager.primaryColorLight,
    primaryColorDark: ColorManager.darkColor,
    disabledColor: ColorManager.disabledColor,
    // card Theme
    cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: ColorManager.disabledColor,
        elevation: AppSpacing.ap4.w),
    appBarTheme: AppBarTheme(
      toolbarHeight: 60.h,
      color: ColorManager.white,
      elevation: 0,
      shadowColor: ColorManager.white,
      iconTheme:
          IconThemeData(color: ColorManager.textColor, size: FontSize.s28),
      titleTextStyle: getRegularStyle(
          color: ColorManager.textColor, fontSize: FontSize.s16),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: ColorManager.darkColor,
      unselectedItemColor: ColorManager.primaryColor,
      type: BottomNavigationBarType.fixed,
      unselectedLabelStyle:
          getBoldStyle(color: ColorManager.textColor, fontSize: FontSize.s18),
      selectedLabelStyle:
          getBoldStyle(color: ColorManager.textColor, fontSize: FontSize.s20),
    ),
// button Theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.disabledColor,
      buttonColor: ColorManager.primaryColor,
      splashColor: ColorManager.primaryColorLight,
    ),

// button Elevation Theme

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.primaryColor,
        maximumSize: const Size(600, 200),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.ap20, vertical: AppSpacing.ap12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.ap12.r)),
        textStyle: getRegularStyle(
            color: ColorManager.textColor, fontSize: FontSize.s16),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(ColorManager.textColor),
      ),
    ),
    textTheme: TextTheme(
      displayLarge:
          getBoldStyle(color: ColorManager.textColor, fontSize: FontSize.s32),
      headlineLarge: getSemiBoldStyle(
          color: ColorManager.textColor, fontSize: FontSize.s30),
      labelLarge:
          getMediumStyle(color: ColorManager.textColor, fontSize: FontSize.s28),
      labelMedium:
          getMediumStyle(fontSize: FontSize.s18, color: ColorManager.textColor),
      labelSmall: getRegularStyle(
          color: ColorManager.textColor, fontSize: FontSize.s16),
      titleLarge: getRegularStyle(
          color: ColorManager.textColor, fontSize: FontSize.s20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppSpacing.ap18.w),
      iconColor: ColorManager.darkColor,
      hintStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.grey),
      labelStyle:
          getMediumStyle(fontSize: FontSize.s16, color: ColorManager.grey),
      errorStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.grey,
            width: AppSpacing.ap1_5.w,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap14.r))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primaryColor,
            width: AppSpacing.ap1_5.w,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap14.r))),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.error,
            width: AppSpacing.ap1_5.w,
          ),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap8.r))),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: ColorManager.primaryColor, width: AppSpacing.ap1_5.w),
          borderRadius: BorderRadius.all(Radius.circular(AppSpacing.ap14.r))),
    ),
  );
}

ThemeData get themeDataDark {
  return ThemeData(
    primaryColor: ColorManager.primaryColor,
    primaryColorLight: ColorManager.primaryColorLight,
    primaryColorDark: ColorManager.darkColor,
    iconTheme: const IconThemeData(color: Colors.black),
    primaryIconTheme: const IconThemeData(color: Colors.black),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: ColorManager.textColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          ColorManager.primaryColor,
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
        shape: MaterialStateProperty.all(const StadiumBorder()),
        textStyle: MaterialStateProperty.all(getRegularStyle(
            fontSize: FontSize.s16, color: ColorManager.textColor)),
      ),
    ),
  );
}
