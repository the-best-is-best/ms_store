import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/active_email/view/active_email_view.dart';
import 'package:ms_store/presentation/forget_password/view/forget_password_view.dart';
import 'package:ms_store/presentation/home/main_view.dart';
import 'package:ms_store/presentation/login/view/login_view.dart';
import 'package:ms_store/presentation/register/view/register_view.dart';
import 'package:ms_store/presentation/rest_password/view/rest_password_view.dart';
import 'package:ms_store/presentation/splash/splash_screen.dart';

class Routes {
  static const non = "/lala";

  static const splashRoute = "/splash";
  static const loginRoute = "/login";
  static const registerRoute = "/register";
  static const forgetPasswordRoute = "/forgetPassword";
  static const resetPasswordRoute = "/resetPassword";
  static const activeEmailRoute = "/activeEmail";

  static const homeRoute = "/home";
}

class RouteGeneratorGetX {
  static List<GetPage> getRoutes() => <GetPage>[
        GetPage(
          name: Routes.splashRoute,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: Routes.loginRoute,
          page: () => LoginView(),
        ),
        GetPage(
          name: Routes.registerRoute,
          page: () => const RegisterView(),
        ),
        GetPage(
          name: Routes.forgetPasswordRoute,
          page: () => const ForgetPasswordView(),
        ),
        GetPage(
          name: Routes.resetPasswordRoute,
          page: () => ResetPasswordView(),
        ),
        GetPage(
          name: Routes.activeEmailRoute,
          page: () => ActiveEmailView(),
        ),
        GetPage(
          name: Routes.homeRoute,
          page: () => const HomeView(),
        ),
      ];
}

Widget unDefinedRoute() {
  return Scaffold(
    appBar: AppBar(
      title: const Text('404'),
    ),
    body: const Center(child: Text('404')),
  );
}
