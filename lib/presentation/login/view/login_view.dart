import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/font_manger.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tbib_loading_transition_button_and_social/tbib_loading_transition_button_and_social.dart';
import '../../../app/components.dart';
import '../../../app/components/common/build_logo.dart';
import '../../../app/components/common/input_field.dart';
import '../../../app/components/login/login_social.dart';
import '../../../app/di.dart';
import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../login_view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final bool canBack;

  late final LoginViewModel _loginController;

  @override
  void initState() {
    if (Get.arguments != null) {
      canBack = Get.arguments['canBack'];
    }

    _loginController = Get.find();

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LoginViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !canBack ? null : AppBar(leading: const ButtonBack()),
      body: Obx(() {
        return _loginController.flowState.value != null
            ? _loginController.flowState.value!.getScreenWidget(
                _GetContentWidget(loginController: _loginController),
              )
            : _GetContentWidget(loginController: _loginController);
      }),
    );
  }
}

class _GetContentWidget extends StatefulWidget {
  final LoginViewModel loginController;

  const _GetContentWidget({Key? key, required this.loginController})
      : super(key: key);

  @override
  State<_GetContentWidget> createState() => _GetContentWidgetState();
}

class _GetContentWidgetState extends State<_GetContentWidget> {
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _passwordNode;
  late final LoadingSignButtonController _loadingSignButtonGoogleController;
  late final LoadingSignButtonController _loadingSignButtonFacebookController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _passwordNode = FocusNode();
    _loadingSignButtonGoogleController = LoadingSignButtonController();
    _loadingSignButtonFacebookController = LoadingSignButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: const EdgeInsets.only(
              top: AppSpacing.ap20,
              left: AppSpacing.ap14,
              right: AppSpacing.ap14),
          child: Column(
            children: [
              Center(
                child: BuildLogo(
                  isDark: Get.isDarkMode,
                ),
              ),
              const SizedBox(height: AppSpacing.ap30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Obx(() {
                      return InputField(
                          label: "${AppStrings.emailTitle} *",
                          keyBoardType: TextInputType.emailAddress,
                          prefixIcon: IconsManger.email,
                          nextNode: _passwordNode,
                          errorText:
                              widget.loginController.alertEmailValid.value,
                          onChanged: (String? val) {
                            if (widget.loginController.loginBySocial.value ==
                                false) {
                              widget.loginController
                                  .setEmailEvent(val?.toLowerCase() ?? "");
                            }
                          });
                    }),
                    const SizedBox(height: AppSpacing.ap30),
                    Obx(() {
                      return InputField(
                          label: "${AppStrings.password} *",
                          keyBoardType: TextInputType.visiblePassword,
                          obscureText: widget.loginController.obscure.value,
                          focusNode: _passwordNode,
                          prefixIcon: IconsManger.password,
                          errorText:
                              widget.loginController.alertPasswordValid.value,
                          suffixWidget: IconButton(
                            onPressed: () {
                              widget.loginController.changeObscureEvent();
                            },
                            icon: Icon(
                              !widget.loginController.obscure.value
                                  ? IconsManger.visibility
                                  : IconsManger.visibilityOff,
                              size: FontSize.s30,
                            ),
                          ),
                          onChanged: (String? val) {
                            if (widget.loginController.loginBySocial.value ==
                                false) {
                              widget.loginController
                                  .setPasswordLoginEvent(val ?? "");
                            }
                          });
                    }),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.ap30),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        widget.loginController.loginBySocial.value == false &&
                                widget.loginController.isAllFieldsValid.value ==
                                    true
                            ? () async {
                                widget.loginController.loginEvent();
                              }
                            : null,
                    child: Text(AppStrings.login),
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed:
                          widget.loginController.loginBySocial.value == false
                              ? () {
                                  initForgetPasswordModel();
                                  Get.toNamed(Routes.forgetPasswordRoute);
                                }
                              : null,
                      child: Text(
                        AppStrings.forgetPassword,
                        style: context.textTheme.labelSmall,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed:
                          widget.loginController.loginBySocial.value == false
                              ? () {
                                  initRegisterModel();
                                  Get.offNamed(Routes.registerRoute);
                                }
                              : null,
                      child: Text(
                        AppStrings.notHaveAccount,
                        style: context.textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.ap18),
              Text(
                AppStrings.orTitle,
                style: context.textTheme.labelMedium,
              ),
              const SizedBox(height: AppSpacing.ap12),
              BuildLoginSocialButton(
                buttonType: ButtonType.facebook,
                title: AppStrings.facebookTitle,
                controller: _loadingSignButtonFacebookController,
                onSubmit: widget.loginController.loginBySocial.value == false
                    ? () {
                        widget.loginController.loginByFaceBook(
                            _loadingSignButtonFacebookController);
                      }
                    : null,
              ),
              const SizedBox(height: AppSpacing.ap16),
              BuildLoginSocialButton(
                buttonType: ButtonType.google,
                title: AppStrings.googleTitle,
                controller: _loadingSignButtonGoogleController,
                onSubmit: widget.loginController.loginBySocial.value == false
                    ? () {
                        widget.loginController
                            .loginByGoogle(_loadingSignButtonGoogleController);
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
