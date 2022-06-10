import 'package:get/instance_manager.dart';
import '../presentation/on_boarding/on_boarding_view_model/on_boarding_view_model_getx.dart';

import '../presentation/active_email/view_model/active_email_controller.dart';
import '../presentation/forget_password/view_model/forget_password_controller.dart';
import '../presentation/home/controller/main_view_controller.dart';
import '../presentation/home/pages/home/view_model/home_controller.dart';
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
  }

  void getOnBoardingController() {
    Get.lazyPut(() => OnBoardingController());
  }

  void getLoginController() {
    Get.lazyPut(() => LoginViewModel(instance()), fenix: true);
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
    Get.lazyPut(() => MainViewController());
  }

  void getHomeViewController() {
    Get.lazyPut(() => HomeController(instance()));
  }
}
