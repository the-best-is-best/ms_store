import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/di.dart';
import 'package:tbib_phone_form_field/l10n/generated/phone_field_localization.dart';

import '../app/resources/theme_manager.dart';
import '../l10n/lang_controller.dart';

import '../app/resources/routes_manger.dart';
import '../app/resources/strings_manager.dart';
import '../presentation/base/user_data/user_data_controller.dart';
import '../presentation/main/pages/fav/view_model/fav_controller.dart';
import 'app_binding.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDataController>(
      init: UserDataController(),
      builder: (_) => GetBuilder<FavController>(
          init: FavController(instance(), instance()),
          builder: (context) {
            return ScreenUtilInit(
              minTextAdapt: true,
              splitScreenMode: true,
              designSize: const Size(480, 960),
              builder: (ctx, child) => GetMaterialApp(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  PhoneFieldLocalization.delegate
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
          }),
    );
  }
}
