import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/components.dart';
import '../../../domain/use_case/users_case/reset_password_case.dart';
import '../../base/base_controller.dart';
import '../../base/base_users_controller.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/strings_manager.dart';

class ResetPasswordController extends GetxController
    with BaseController, BaseUserController {
  final ResetPasswordCase _resetPasswordCase;

  ResetPasswordController(this._resetPasswordCase);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startFlow();
  }

  Rxn<String?> alertPinValid = Rxn<String>();
  Rxn<String?> alertPasswordValid = Rxn<String>();
  Rxn<String?> alertPasswordAgainValid = Rxn<String>();

  String? isPinValid(String pin) {
    if (pin.isEmpty) {
      return AppStrings.required;
    } else if (pin.length < 5) {
      return AppStrings.pinLengthError;
    } else {
      return null;
    }
  }

  void setPinEvent(String pin) {
    userDataObject.value = userDataObject.value.copyWith(pin: pin);
    alertPinValid.value = isPinValid(pin);
    validPinAndPasswordEvent();
  }

  @override
  void setPasswordEvent(String password, {bool isLogin = false}) {
    super.setPasswordEvent(password);
    alertPasswordAgainValid.value =
        isPasswordAginValidEvent(userDataObject.value.passwordAgin);

    validPinAndPasswordEvent();
  }

  @override
  void setPasswordAgainEvent(String password) {
    super.setPasswordEvent(password);

    alertPasswordValid.value =
        isPasswordAginValidEvent(userDataObject.value.password);

    validPinAndPasswordEvent();
  }

  void validPinAndPasswordEvent() {
    if (userDataObject.value.password.isNotEmpty &&
        userDataObject.value.passwordAgin.isNotEmpty &&
        userDataObject.value.pin.isNotEmpty) {
      if (alertPasswordValid.value == null &&
          alertPasswordAgainValid.value == null &&
          alertPinValid.value == null) {
        isAllFieldsValid.value = true;
      } else {
        isAllFieldsValid.value = false;
      }
    } else {
      isAllFieldsValid.value = false;
    }
  }

  void resetPasswordEvent() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);

    var result =
        await _resetPasswordCase.execute(ResetPasswordCasePasswordInput(
      pin: userDataObject.value.pin,
      password: userDataObject.value.password,
      email: userDataObject.value.email,
    ));
    await waitStateChanged(duration: 1800);
    result.fold((failure) {
      if (failure.statusCode == -6) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_NETWORK_ERROR_STATE,
            message: failure.messages,
            color: Colors.white);
      } else {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }
    }, (data) {
      flowState.value = ContentState();
      flowState.value = SuccessState(
          stateRendererType: StateRendererType.POPUP_SUCCESS_STATE,
          message: AppStrings.passwordChanged,
          color: Colors.white);
    });
  }

  Rx<bool> obsecure = true.obs;

  void changeObsecureEvent() {
    obsecure.value = !obsecure.value;
  }

  Rx<bool> obsecureAgain = true.obs;

  void changeObsecureAgainEvent() {
    obsecureAgain.value = !obsecureAgain.value;
  }
}