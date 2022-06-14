import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import '../core/resources/theme_manager.dart';
import '../l10n/lang_controller.dart';

import '../core/resources/routes_manger.dart';
import '../core/resources/strings_manager.dart';
import 'app_binding.dart';
import 'extensions.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance =
      MyApp._internal(); // singleton or single instance

  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(480, 960),
      builder: (ctx, child) => GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        fallbackLocale: const Locale('en', ''),
        initialBinding: AppBinding(),
        debugShowCheckedModeBanner: false,
        translations: LangController(),
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        locale: Locale(Get.deviceLocale!.languageCode),
        onGenerateTitle: (BuildContext context) => AppStrings.appTitle,
        theme: Get.isDarkMode ? themeDataDark : themeDataLight,
        getPages: RouteGeneratorGetX.getRoutes(),
        initialRoute: '/splash',
        unknownRoute: GetPage(
          name: '/',
          page: () => unDefinedRoute(),
        ),
      ),
    );
  }
}
