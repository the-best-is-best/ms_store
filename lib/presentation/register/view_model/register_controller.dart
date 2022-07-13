import 'package:get/get.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../domain/use_case/users_case/register_use_case.dart';
import '../../base/base_controller.dart';
import '../../base/base_users_controller.dart';
import '../../common/freezed/freezed_data.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class RegisterController extends GetxController
    with BaseController, BaseUserController {
  final RegisterUserCase _registerUserCase;
  RegisterController(this._registerUserCase);

  @override
  void onInit() {
    super.onInit();
    startFlow();
  }

  Rxn<String?> alertUserValid = Rxn<String?>();

  void setUserNameEvent(String user) {
    userDataObject.value = userDataObject.value.copyWith(userName: user);
    alertUserValid.value = isUserNameValidEvent(user);
    validAllFields();
  }

  String? isUserNameValidEvent(String userName) {
    if (userName.isEmpty) {
      return AppStrings.required;
    } else {
      if (userName.length < 5) {
        return AppStrings.userNameLength;
      } else {
        return null;
      }
    }
  }

  Rxn<String?> alertPrivacyPolicyChecked = Rxn<String?>();

  void isPrivacyPolicyChecked(bool checked) {
    if (!checked) {
      alertPrivacyPolicyChecked.value = AppStrings.required;
    } else {
      alertPrivacyPolicyChecked.value = '';
    }
    validAllFields();
  }

  @override
  void setEmailEvent(String email) {
    super.setEmailEvent(email);
    alertEmailValid.value = isEmailValidEvent(email);
    validAllFields();
  }

  @override
  void setPasswordEvent(String password) {
    super.setPasswordEvent(password);

    alertPasswordValid.value = isPasswordValidEvent(password);
    validAllFields();
  }

  @override
  void setPasswordAgainEvent(String password) {
    super.setPasswordAgainEvent(password);
    validAllFields();
  }

  Rx<bool> obscure = true.obs;

  void changeObscureEvent() {
    obscure.value = !obscure.value;
  }

  Rx<bool> obscureAgain = true.obs;

  void changeObscureAgainEvent() {
    obscureAgain.value = !obscureAgain.value;
  }

  void validAllFields() {
    UserDataObject value = userDataObject.value;
    if (value.email.isNotEmpty &&
        alertPrivacyPolicyChecked.value != null &&
        alertPrivacyPolicyChecked.value!.isEmpty &&
        value.password.isNotEmpty &&
        value.passwordAgin.isNotEmpty &&
        value.userName.isNotEmpty) {
      if (alertEmailValid.value == null &&
          alertPasswordValid.value == null &&
          alertPasswordAgainValid.value == null &&
          alertUserValid.value == null) {
        isAllFieldsValid.value = true;
      } else {
        isAllFieldsValid.value = false;
      }
    } else {
      isAllFieldsValid.value = false;
    }
  }

  void registerEvent() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    UserDataObject value = userDataObject.value;
    var result = await _registerUserCase.execute(RegisterUserCaseInput(
        email: value.email,
        password: value.password,
        userName: value.userName));
    result.fold((failure) {
      if (failure.statusCode == -6) {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_NETWORK_ERROR_STATE,
            message: failure.messages,
            color: ColorManager.white);
      } else {
        flowState.value = ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: failure.messages);
      }
    }, (data) {
      flowState.value = SuccessState(
        stateRendererType: StateRendererType.POPUP_CHECK_EMAIL_STATE,
        message: AppStrings.checkEmail,
        color: ColorManager.white,
      );
    });
  }
}
