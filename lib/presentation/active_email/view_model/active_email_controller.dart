import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../app/app_refs.dart';
import '../../../app/components.dart';
import '../../../app/di.dart';
import '../../../domain/models/users_model.dart';
import '../../../domain/use_case/users_case/active_email_case.dart';
import '../../base/base_controller.dart';
import '../../base/base_users_controller.dart';
import '../../base/user_data/user_data_controller.dart';
import '../../common/freezed/freezed_data.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../app/resources/strings_manager.dart';
import '../../main/pages/home/view_model/home_controller.dart';

class ActiveEmailController extends GetxController
    with BaseController, BaseUserController {
  final ActiveEmailCase _activeEmailCase;

  ActiveEmailController(this._activeEmailCase);
  @override
  void onInit() {
    super.onInit();
    startFlow();
  }

  Rxn<String?> alertPinValid = Rxn<String>();

  String? isPinValid(String pin) {
    if (pin.isEmpty) {
      return AppStrings.required;
    } else if (pin.length < 5) {
      return AppStrings.pinLengthError;
    } else {
      return null;
    }
  }

  @override
  void setEmailEvent(String email) {
    super.setEmailEvent(email);
    validPinEvent();
  }

  void setPinEvent(String pin) {
    userDataObject.value = userDataObject.value.copyWith(pin: pin);
    alertPinValid.value = isPinValid(pin);
    validPinEvent();
  }

  void validPinEvent() {
    if (userDataObject.value.pin.isNotEmpty) {
      if (isPinValid(userDataObject.value.pin) == null) {
        isAllFieldsValid.value = true;
      } else {
        isAllFieldsValid.value = false;
      }
    } else {
      isAllFieldsValid.value = false;
    }
  }

  void activeEmailEvent() async {
    flowState.value = LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading);
    UserDataObject value = userDataObject.value;
    var result = await _activeEmailCase
        .execute(ActiveEmailCaseInput(value.email, value.pin));
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
    }, (data) async {
      await getUserData(data);
    });
  }

  Future getUserData(UserModel data) async {
    await AppPrefs().updateUserData(data);
    await waitStateChanged(duration: 1100);

    UserDataController userDataController = Get.find();
    await userDataController.getUserData();
    await initHomeModel();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      Get.offNamedUntil(Routes.homeRoute, (route) => false);
    });
  }
}
