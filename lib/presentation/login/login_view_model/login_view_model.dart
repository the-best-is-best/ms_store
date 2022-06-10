import 'package:email_validator/email_validator.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../app/components.dart';
import '../../../domain/use_case/users_case/login_use_case.dart';
import '../../base/base_controller.dart';
import '../../base/base_users_controller.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';

class LoginViewModel extends GetxController
    with BaseController, BaseUserController {
  final LoginUserCase _loginUserCase;
  LoginViewModel(this._loginUserCase);

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
    await waitStateChanged(duration: 1800);
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
    }, (data) {
      /*  flowState.value = ContentState();
      print(data.email);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        initHomeModel();
        Get.offNamedUntil(Routes.homeRoute, (route) => false);
      });*/
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

  void changeObscureEvent() {
    obscure.value = !obscure.value;
  }
}
