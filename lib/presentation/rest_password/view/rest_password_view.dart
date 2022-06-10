import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../app/di.dart';
import '../view_model/rest_password_controller.dart';

import '../../../app/components.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../resources/icons_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class ResetPasswordView extends StatefulWidget {
  final String email = Get.arguments['email'];
  ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final TextEditingController _pinController;

  late final TextEditingController _passwordController;
  late final FocusNode _passwordNode;

  late final TextEditingController _passwordAgainController;
  late final FocusNode _passwordAgainNode;
  late final GlobalKey<FormState> _formKey;
  late final ResetPasswordController _resetPasswordController;

  @override
  void initState() {
    _pinController = TextEditingController();

    _passwordNode = FocusNode();
    _passwordAgainNode = FocusNode();
    _resetPasswordController = Get.find();
    _formKey = GlobalKey<FormState>();
    // TODO: implement initState
    super.initState();
    _resetPasswordController.setEmailEvent(widget.email);
  }

  @override
  void dispose() {
    _pinController.dispose();

    //Get.delete<LoginViewModelGetX>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _resetPasswordController.flowState.value != null
            ? _resetPasswordController.flowState.value!.getScreenWidget(
                _getContentWidget(),
                retryActionFunction: _resetPasswordController.flowState.value
                            ?.getStateRendererType() ==
                        StateRendererType.POPUP_SUCCESS_STATE
                    ? () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          initLoginModel();
                          Get.offNamedUntil(Routes.loginRoute, (route) => false,
                              arguments: {'fromForgetPassword': true});
                        });
                      }
                    : null)
            : _getContentWidget();
      }),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: AppSpacing.ap100.h,
            left: AppSpacing.ap14,
            right: AppSpacing.ap14),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: logo(
                  logoHeight: 150.h,
                  isDark: Get.isDarkMode,
                ),
              ),
              SizedBox(
                height: AppSpacing.ap30.h,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: _pinController,
                    focusNode: _passwordNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        IconsManger.pin,
                        size: AppSpacing.ap30.w,
                      ),
                      label: Text("${AppStrings.pinCode} *"),
                      errorText: _resetPasswordController.alertPinValid.value,
                    ),
                    onChanged: (String? val) {
                      _resetPasswordController.setPinEvent(val ?? "");
                    },
                  ),
                  SizedBox(
                    height: AppSpacing.ap30.h,
                  ),
                  Obx(() {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: _passwordAgainNode,
                      obscureText: _resetPasswordController.obsecure.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconsManger.password,
                          size: AppSpacing.ap30.w,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _resetPasswordController.changeObsecureEvent();
                          },
                          icon: Icon(
                            !_resetPasswordController.obsecure.value
                                ? IconsManger.visibility
                                : IconsManger.visibilityOff,
                            size: AppSpacing.ap30.w,
                          ),
                        ),
                        label: Text("${AppStrings.password} *"),
                        errorText:
                            _resetPasswordController.alertPasswordValid.value,
                      ),
                      onChanged: (String? val) {
                        _resetPasswordController.setPasswordEvent(val ?? "");
                      },
                    );
                  }),
                  SizedBox(
                    height: AppSpacing.ap30.h,
                  ),
                  Obx(() {
                    return TextFormField(
                      controller: _passwordAgainController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _resetPasswordController.obsecureAgain.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconsManger.password,
                          size: AppSpacing.ap30.w,
                        ),
                        label: Text("${AppStrings.passwordAgain} *"),
                        errorText: _resetPasswordController
                            .alertPasswordAgainValid.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            _resetPasswordController.changeObsecureAgainEvent();
                          },
                          icon: Icon(
                            !_resetPasswordController.obsecureAgain.value
                                ? IconsManger.visibility
                                : IconsManger.visibilityOff,
                            size: AppSpacing.ap30.w,
                          ),
                        ),
                      ),
                      onChanged: (String? val) {
                        _resetPasswordController
                            .setPasswordAgainEvent(val ?? "");
                      },
                    );
                  }),
                ],
              ),
              SizedBox(
                height: AppSpacing.ap30.h,
              ),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _resetPasswordController.isAllFieldsValid.value
                          ? () {
                              _resetPasswordController.resetPasswordEvent();
                            }
                          : null,
                      child: Text(AppStrings.resetPasswordTitle),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
