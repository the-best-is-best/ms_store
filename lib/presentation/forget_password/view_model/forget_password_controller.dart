import 'package:get/get.dart';
import '../../../domain/use_case/users_case/forget_password_case.dart';
import '../../base/base_controller.dart';
import '../../base/base_users_controller.dart';
import '../../../app/resources/color_manager.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../app/resources/strings_manager.dart';

class ForgetPasswordViewGetX extends GetxController
    with BaseController, BaseUserController {
  final ForgetPasswordCase _forgetPasswordCase;

  ForgetPasswordViewGetX(this._forgetPasswordCase);
  @override
  void onInit() {
    startFlow();
    super.onInit();
  }

  @override
  void setEmailEvent(String email) {
    super.setEmailEvent(email);
    isAllFieldsValid.value = true;
  }

  void forgetPasswordEvent() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);

    var result = await _forgetPasswordCase
        .execute(ForgetPasswordInput(userDataObject.value.email));
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
