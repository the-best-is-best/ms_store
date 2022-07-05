import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/presentation/about/about_view.dart';
import 'package:ms_store/presentation/account/view/account_view.dart';
import 'package:ms_store/presentation/active_email/view/active_email_view.dart';
import 'package:ms_store/presentation/contact_us/view/contact_us_view.dart';
import 'package:ms_store/presentation/forget_password/view/forget_password_view.dart';
import 'package:ms_store/presentation/login/view/login_view.dart';
import 'package:ms_store/presentation/products_views/details/view/product_details_view.dart';
import 'package:ms_store/presentation/register/view/register_view.dart';
import 'package:ms_store/presentation/rest_password/view/rest_password_view.dart';
import 'package:ms_store/presentation/search/view/search_view.dart';
import 'package:ms_store/presentation/splash/splash_screen.dart';

import '../../presentation/main/main_view.dart';
import '../../presentation/products_views/product_by_cat/view/product_by_cat_view.dart';

class Routes {
  static const non = "/";

  static const splashRoute = "/splash";
  static const loginRoute = "/login";
  static const registerRoute = "/register";
  static const forgetPasswordRoute = "/forgetPassword";
  static const resetPasswordRoute = "/resetPassword";
  static const activeEmailRoute = "/activeEmail";
  static const homeRoute = "/home";
  static const productDetailsRoute = "/productDetails";
  static const productByCatIdRoute = "/productByCatId";
  static const aboutRoute = "/about";
  static const contactUsRoute = "/contactUsRoute";
  static const searchRoute = "/searchRoute";
  static const accountRoute = "/accountRoute";
}

class RouteGeneratorGetX {
  static List<GetPage> getRoutes() => <GetPage>[
        GetPage(
          name: Routes.splashRoute,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: Routes.loginRoute,
          page: () => const LoginView(),
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
          page: () => const ResetPasswordView(),
        ),
        GetPage(
          name: Routes.activeEmailRoute,
          page: () => const ActiveEmailView(),
        ),
        GetPage(
          name: Routes.homeRoute,
          page: () => const MainView(),
        ),
        GetPage(
          name: Routes.productDetailsRoute,
          page: () => ProductDetailsView(),
        ),
        GetPage(
          name: Routes.productByCatIdRoute,
          page: () => const ProductByCat(),
        ),
        GetPage(
          name: Routes.aboutRoute,
          page: () => const AboutView(),
        ),
        GetPage(
          name: Routes.contactUsRoute,
          page: () => const ContactUsView(),
        ),
        GetPage(
          name: Routes.searchRoute,
          page: () => const SearchView(),
        ),
        GetPage(
          name: Routes.accountRoute,
          page: () => const AccountView(),
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
