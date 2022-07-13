import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/font_manger.dart';

import '../../../app/components/active_code/build_pin_code.dart';
import '../../../app/components/common/build_logo.dart';
import '../../../app/di.dart';
import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../view_model/rest_password_controller.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final FocusNode _passwordNode;

  late final FocusNode _passwordAgainNode;
  late final GlobalKey<FormState> _formKey;
  late final ResetPasswordController _resetPasswordController;
  final String email = Get.arguments['email'];

  @override
  void initState() {
    _passwordNode = FocusNode();
    _passwordAgainNode = FocusNode();
    _resetPasswordController = Get.find();
    _formKey = GlobalKey<FormState>();
    super.initState();
    _resetPasswordController.setEmailEvent(email);
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
                _GetContextWidget(
                    formKey: _formKey,
                    resetPasswordController: _resetPasswordController,
                    passwordNode: _passwordNode,
                    passwordAgainNode: _passwordAgainNode),
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
            : _GetContextWidget(
                formKey: _formKey,
                resetPasswordController: _resetPasswordController,
                passwordNode: _passwordNode,
                passwordAgainNode: _passwordAgainNode);
      }),
    );
  }
}

class _GetContextWidget extends StatelessWidget {
  const _GetContextWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
    required ResetPasswordController resetPasswordController,
    required FocusNode passwordNode,
    required FocusNode passwordAgainNode,
  })  : _formKey = formKey,
        _resetPasswordController = resetPasswordController,
        _passwordNode = passwordNode,
        _passwordAgainNode = passwordAgainNode,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final ResetPasswordController _resetPasswordController;
  final FocusNode _passwordNode;
  final FocusNode _passwordAgainNode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
            top: AppSpacing.ap100,
            left: AppSpacing.ap14,
            right: AppSpacing.ap14),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: BuildLogo(
                  isDark: Get.isDarkMode,
                ),
              ),
              const SizedBox(height: AppSpacing.ap30),
              Column(
                children: [
                  BuildPinCodeTextField(
                      onChanged: (String? val) {
                        _resetPasswordController.setPinEvent(val ?? "");
                      },
                      onSubmitted: (String? v) => _passwordNode.requestFocus()),
                  const SizedBox(height: AppSpacing.ap30),
                  Obx(() {
                    return TextFormField(
                      // controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: _passwordAgainNode,
                      obscureText: _resetPasswordController.obscure.value,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(IconsManger.password, size: FontSize.s30),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _resetPasswordController.changeObscureEvent();
                          },
                          icon: Icon(
                            !_resetPasswordController.obscure.value
                                ? IconsManger.visibility
                                : IconsManger.visibilityOff,
                            size: FontSize.s30,
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
                  const SizedBox(height: AppSpacing.ap30),
                  Obx(() {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _resetPasswordController.obscureAgain.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          IconsManger.password,
                          size: FontSize.s30,
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
                            size: FontSize.s30,
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
              const SizedBox(height: AppSpacing.ap30),
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
