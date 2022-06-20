import 'package:get/instance_manager.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/main/pages/cart/view_model/cart_controller.dart';
import 'package:ms_store/presentation/main/pages/category/view_model/category_view_model.dart';
import 'package:ms_store/presentation/main/pages/fav/view_model/fav_controller.dart';
import 'package:ms_store/presentation/main/pages/settings/view_model/settings_controller.dart';
import '../presentation/main/pages/home/view_model/home_controller.dart';
import '../presentation/main/controller/main_view_controller.dart';
import '../presentation/on_boarding/on_boarding_view_model/on_boarding_view_model_getx.dart';

import '../presentation/active_email/view_model/active_email_controller.dart';
import '../presentation/forget_password/view_model/forget_password_controller.dart';
import '../presentation/login/login_view_model/login_view_model.dart';
import '../presentation/register/view_model/register_controller.dart';
import '../presentation/rest_password/view_model/rest_password_controller.dart';
import 'di.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    getOnBoardingController();
    //login
    getLoginController();

    getUserDataController(); // fav
    // register
    getRegisterController();
    // active email
    getActiveController();
    // forget password
    getForgetPasswordController();

    // reset password
    getResetPasswordController();

    // main view
    getMainViewController();
    // home
    getHomeViewController();
    // category
    getCategoryViewController();
// fav
    getFavoriteViewController();
    //cart
    getCartViewController();
    // setting
    getSettingViewController();
  }

  void getOnBoardingController() {
    Get.lazyPut(() => OnBoardingController());
  }

  void getLoginController() {
    Get.lazyPut(() => LoginViewModel(instance(), instance()), fenix: true);
  }

  void getUserDataController() {
    Get.lazyPut(() => UserDataController(), fenix: true);
  }

  void getRegisterController() {
    Get.lazyPut(() => RegisterController(instance()), fenix: true);
  }

  void getActiveController() {
    Get.lazyPut(() => ActiveEmailController(instance()), fenix: true);
  }

  void getResetPasswordController() {
    Get.lazyPut(() => ResetPasswordController(instance()), fenix: true);
  }

  void getForgetPasswordController() {
    Get.lazyPut(() => ForgetPasswordViewGetX(instance()), fenix: true);
  }

  void getMainViewController() {
    Get.lazyPut(() => MainViewController(), fenix: true);
  }

  void getHomeViewController() {
    Get.lazyPut(() => HomeController(instance(), instance()), fenix: true);
  }

  void getCategoryViewController() {
    Get.lazyPut(() => CategoryController(instance()), fenix: true);
  }

  void getFavoriteViewController() {
    Get.lazyPut(() => FavController(instance(), instance(), instance()),
        fenix: true);
  }

  void getCartViewController() {
    Get.lazyPut(() => CartController(instance()), fenix: true);
  }

  void getSettingViewController() {
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}
