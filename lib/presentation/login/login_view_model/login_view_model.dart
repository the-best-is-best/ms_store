import 'package:email_validator/email_validator.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ms_store/domain/use_case/users_case/login_social_use_case.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/main/pages/home/view_model/home_controller.dart';
import 'package:tbib_loading_transition_button_and_social/tbib_loading_transition_button_and_social.dart';
import '../../../app/app_refs.dart';
import '../../../app/components.dart';
import '../../../app/di.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../domain/models/users_model.dart';
import '../../../domain/use_case/users_case/login_use_case.dart';
import '../../base/base_controller.dart';
import '../../base/base_users_controller.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends GetxController
    with BaseController, BaseUserController {
  final LoginUserCase _loginUserCase;
  final LoginBySocialUserCase _loginBySocialUserCase;

  LoginViewModel(this._loginUserCase, this._loginBySocialUserCase);
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final facebookSignIn = FacebookAuth.instance;

  @override
  void onInit() {
    super.onInit();
    startFlow();
  }

  Rx<bool> obscure = true.obs;

  @override
  void setEmailEvent(String email) {
    super.setEmailEvent(email);
    validEmailAndPasswordEvent();
  }

  @override
  void setPasswordLoginEvent(String password) {
    super.setPasswordLoginEvent(password);
    validEmailAndPasswordEvent();
  }

  void loginEvent() async {
    super.flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);

    var result = await _loginUserCase.execute(LoginUserCaseInput(
        userDataObject.value.email, userDataObject.value.password));
    result.fold((failure) {
      if (failure.statusCode == -6) {
        super.flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_NETWORK_ERROR_STATE,
            message: failure.messages,
            color: ColorManager.white);
      } else {
        super.flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }
    }, (data) async {
      if (data.emailActive == 0) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          initActiveEmailModel();
          Get.offNamedUntil(Routes.activeEmailRoute, (route) => false,
              arguments: {'email': data.email});
        });
      } else {
        flowState.value = ContentState();
        await getUserData(data);
      }
    });
  }

  void validEmailAndPasswordEvent() {
    if (userDataObject.value.email.isNotEmpty &&
        userDataObject.value.password.isNotEmpty) {
      if (EmailValidator.validate(userDataObject.value.email) &&
          alertPasswordValid.value == null &&
          userDataObject.value.password.isNotEmpty) {
        isAllFieldsValid.value = true;
      } else {
        isAllFieldsValid.value = false;
      }
    } else {
      isAllFieldsValid.value = false;
    }
  }

  RxBool loginBySocial = false.obs;

  Future<void> loginByGoogle(
    LoadingSignButtonController loadingSignButtonController,
  ) async {
    loginBySocial.value = true;
    late GoogleSignInAccount? getUser;
    try {
      getUser = await googleSignIn.signIn();
    } catch (ex) {
      loginBySocial.value = false;

      loadingSignButtonController.onError();
      return;
    }
    if (getUser == null) {
      loginBySocial.value = false;

      loadingSignButtonController.onError();
      return;
    }

    var result = await _loginBySocialUserCase.execute(
        LoginBySocialUserCaseInput(
            email: getUser.email,
            loginBySocial: 1,
            tokenSocial: getUser.id,
            userName: getUser.displayName ?? "Your Name Here"));
    result.fold((failure) {
      if (failure.statusCode == -6) {
        loginBySocial.value = false;

        loadingSignButtonController.onError();
        super.flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_NETWORK_ERROR_STATE,
            message: failure.messages,
            color: ColorManager.white);
      } else {
        loginBySocial.value = false;

        loadingSignButtonController.onError();

        super.flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }
    }, (data) async {
      loadingSignButtonController.onSuccess();
      await getUserData(data);
    });
  }

  Future<void> loginByFaceBook(
    LoadingSignButtonController loadingSignButtonController,
  ) async {
    loginBySocial.value = true;
    late LoginResult result;
    try {
      result = await facebookSignIn.login();
    } catch (ex) {
      loginBySocial.value = false;

      loadingSignButtonController.onError();
      return;
    }
    if (result.status == LoginStatus.success) {
      // you are logged
      if (result.accessToken != null) {
        final getUser = await FacebookAuth.i.getUserData(
          fields: "id,name,email,picture.height(400).width(400)",
        );

        var result = await _loginBySocialUserCase.execute(
            LoginBySocialUserCaseInput(
                email: getUser['email'],
                loginBySocial: 2,
                tokenSocial: getUser['id'],
                userName: getUser['userName'] ?? "Your Name Here"));
        result.fold((failure) {
          if (failure.statusCode == -6) {
            loginBySocial.value = false;

            loadingSignButtonController.onError();
            super.flowState.value = ErrorState(
                stateRendererType: StateRendererType.POPUP_NETWORK_ERROR_STATE,
                message: failure.messages,
                color: ColorManager.white);
          } else {
            loadingSignButtonController.onError();

            super.flowState.value = ErrorState(
                stateRendererType: StateRendererType.POPUP_ERROR_STATE,
                message: failure.messages);
          }
        }, (data) async {
          loadingSignButtonController.onSuccess();
          await getUserData(data);
        });
      } else {
        loginBySocial.value = false;

        loadingSignButtonController.onError();
        return;
      }
    } else {
      loginBySocial.value = false;

      loadingSignButtonController.onError();
      return;
    }
  }

  void changeObscureEvent() {
    obscure.value = !obscure.value;
  }

  Future getUserData(UserModel data) async {
    await AppPrefs().updateUserData(data);
    await waitStateChanged(duration: 1100);
    bool homeRepaired = Get.isPrepared<HomeController>();
    if (!homeRepaired) {
      UserDataController userDataController = Get.find();
      await userDataController.getUserData();
      HomeController homeController = Get.find();
      homeController.getHomeData();
      Get.back();
    } else {
      await initHomeModel();

      SchedulerBinding.instance.addPostFrameCallback((_) async {
        Get.offNamedUntil(Routes.homeRoute, (route) => false);
      });
    }
    loginBySocial.value = false;
  }
}
