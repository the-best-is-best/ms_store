import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/font_manger.dart';
import 'package:tbib_loading_transition_button_and_social/tbib_loading_transition_button_and_social.dart';
import '../../../app/di.dart';
import '../../../gen/assets.gen.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../login_view_model/login_view_model.dart';
import '../../../core/resources/icons_manger.dart';
import '../../../core/resources/routes_manger.dart';
import '../../../core/resources/values_manager.dart';

import '../../../app/components.dart';
import '../../../core/resources/strings_manager.dart';

class LoginView extends StatefulWidget {
  final bool canBack = Get.arguments['canBack'];
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _passwordNode;
  late final LoadingSignButtonController _loadingSignButtonGoogleController;
  late final LoadingSignButtonController _loadingSignButtonFacebookController;

  late final LoginViewModel _loginController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _passwordNode = FocusNode();
    _loginController = Get.find();
    _loadingSignButtonGoogleController = LoadingSignButtonController();
    _loadingSignButtonFacebookController = LoadingSignButtonController();
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
      appBar: !widget.canBack
          ? null
          : AppBar(
              leading: IconButton(
              icon: Icon(
                  GetPlatform.isIOS ? CupertinoIcons.back : Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )),
      body: Obx(() {
        return _loginController.flowState.value != null
            ? _loginController.flowState.value!.getScreenWidget(
                _getContentWidget(),
              )
            : _getContentWidget();
      }),
    );
  }

  Widget _getContentWidget() {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: EdgeInsets.only(
              top: AppSpacing.ap20.h,
              left: AppSpacing.ap14,
              right: AppSpacing.ap14),
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Obx(() {
                      return InputField(
                          themeData: themeData,
                          label: "${AppStrings.emailTitle} *",
                          keyBoardType: TextInputType.emailAddress,
                          prefixIcon: IconsManger.email,
                          nextNode: _passwordNode,
                          errorText: _loginController.alertEmailValid.value,
                          onChanged: (String? val) {
                            if (_loginController.loginBySocial.value == false) {
                              _loginController.setEmailEvent(val ?? "");
                            }
                          });
                    }),
                    SizedBox(
                      height: AppSpacing.ap30.h,
                    ),
                    Obx(() {
                      return InputField(
                          themeData: themeData,
                          label: "${AppStrings.password} *",
                          keyBoardType: TextInputType.visiblePassword,
                          obscureText: _loginController.obscure.value,
                          focusNode: _passwordNode,
                          prefixIcon: IconsManger.password,
                          errorText: _loginController.alertPasswordValid.value,
                          suffixWidget: IconButton(
                            onPressed: () {
                              _loginController.changeObscureEvent();
                            },
                            icon: Icon(
                              !_loginController.obscure.value
                                  ? IconsManger.visibility
                                  : IconsManger.visibilityOff,
                              size: AppSpacing.ap30.sp,
                            ),
                          ),
                          onChanged: (String? val) {
                            if (_loginController.loginBySocial.value == false) {
                              _loginController.setPasswordLoginEvent(val ?? "");
                            }
                          });
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: AppSpacing.ap30.h,
              ),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loginController.loginBySocial.value == false &&
                            _loginController.isAllFieldsValid.value == true
                        ? () async {
                            _loginController.loginEvent();
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
                      onPressed: _loginController.loginBySocial.value == false
                          ? () {
                              initForgetPasswordModel();
                              Get.toNamed(Routes.forgetPasswordRoute);
                            }
                          : null,
                      child: Text(
                        AppStrings.forgetPassword,
                        style: themeData.textTheme.labelSmall,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _loginController.loginBySocial.value == false
                          ? () {
                              initRegisterModel();
                              Get.offNamed(Routes.registerRoute);
                            }
                          : null,
                      child: Text(
                        AppStrings.notHaveAccount,
                        style: themeData.textTheme.labelSmall,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppSpacing.ap18.h,
              ),
              Text(
                AppStrings.orTitle,
                style: themeData.textTheme.labelMedium,
              ),
              SizedBox(
                height: AppSpacing.ap12.h,
              ),
              LoadingSignButton(
                width: size.width,
                height: 50,
                buttonType: ButtonType.facebook,
                fontSize: FontSize.s18,
                imageSize: AppSize.ap20,
                controller: _loadingSignButtonFacebookController,
                durationSuccess: const Duration(seconds: 1),
                progressIndicatorColor: ColorManager.primaryColor,
                successWidget: Lottie.asset(
                  const $AssetsJsonGen().success,
                ),
                onSubmit: _loginController.loginBySocial.value == false
                    ? () {
                        _loginController.loginByFaceBook(
                            _loadingSignButtonFacebookController);
                      }
                    : null,
              ),
              SizedBox(
                height: AppSpacing.ap16.h,
              ),
              LoadingSignButton(
                width: size.width,
                height: 50,
                buttonType: ButtonType.google,
                fontSize: FontSize.s18,
                imageSize: AppSize.ap20,
                controller: _loadingSignButtonGoogleController,
                errorColor: ColorManager.error,
                durationSuccess: const Duration(seconds: 1),
                progressIndicatorColor: ColorManager.primaryColor,
                successWidget: Lottie.asset(
                  const $AssetsJsonGen().success,
                ),
                onSubmit: _loginController.loginBySocial.value == false
                    ? () {
                        _loginController
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
