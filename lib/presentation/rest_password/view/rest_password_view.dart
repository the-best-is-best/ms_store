import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../app/di.dart';
import '../view_model/rest_password_controller.dart';

import '../../../app/components.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../../core/resources/icons_manger.dart';
import '../../../core/resources/routes_manger.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/resources/values_manager.dart';

class ResetPasswordView extends StatefulWidget {
  final String email = Get.arguments['email'];
  ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final FocusNode _passwordNode;

  late final FocusNode _passwordAgainNode;
  late final GlobalKey<FormState> _formKey;
  late final ResetPasswordController _resetPasswordController;

  @override
  void initState() {
    _passwordNode = FocusNode();
    _passwordAgainNode = FocusNode();
    _resetPasswordController = Get.find();
    _formKey = GlobalKey<FormState>();
    super.initState();
    _resetPasswordController.setEmailEvent(widget.email);
  }

  @override
  void dispose() {
    // _pinController.dispose();

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
                              arguments: {'canBack': false});
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
                  isDark: Get.isDarkMode,
                ),
              ),
              SizedBox(
                height: AppSpacing.ap30.h,
              ),
              Column(
                children: [
                  pinCodeTextField(context, (String? val) {
                    _resetPasswordController.setPinEvent(val ?? "");
                  }, onSubmitted: (String? v) => _passwordNode.requestFocus()),
                  // TextFormField(
                  //   //  controller: _pinController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: InputDecoration(
                  //     prefixIcon: Icon(
                  //       IconsManger.pin,
                  //       size: AppSpacing.ap30.w,
                  //     ),
                  //     label: Text("${AppStrings.pinCode} *"),
                  //     errorText: _resetPasswordController.alertPinValid.value,
                  //   ),
                  //   onChanged: (String? val) {
                  //     _resetPasswordController.setPinEvent(val ?? "");
                  //   },
                  // ),
                  SizedBox(
                    height: AppSpacing.ap30.h,
                  ),
                  Obx(() {
                    return TextFormField(
                      // controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: _passwordAgainNode,
                      obscureText: _resetPasswordController.obscure.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconsManger.password,
                          size: AppSpacing.ap30.w,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _resetPasswordController.changeObscureEvent();
                          },
                          icon: Icon(
                            !_resetPasswordController.obscure.value
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
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _resetPasswordController.obscureAgain.value,
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
                            _resetPasswordController.changeObscureAgainEvent();
                          },
                          icon: Icon(
                            !_resetPasswordController.obscureAgain.value
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
