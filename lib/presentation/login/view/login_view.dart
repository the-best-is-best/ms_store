import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../login_view_model/login_view_model.dart';
import '../../../resources/icons_manger.dart';
import '../../../resources/routes_manger.dart';
import '../../../resources/values_manager.dart';

import '../../../app/components.dart';
import '../../../resources/strings_manager.dart';

class LoginView extends StatefulWidget {
  final bool fromForgetPassword = Get.arguments['fromForgetPassword'];
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _passwordNode;

  late final LoginViewModel _loginController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _passwordNode = FocusNode();
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
      appBar: widget.fromForgetPassword
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

    return SingleChildScrollView(
        child: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Padding(
          padding: EdgeInsets.only(
              top: AppSpacing.ap100.h,
              left: AppSpacing.ap14,
              right: AppSpacing.ap14),
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
                            _loginController.setEmailEvent(val ?? "");
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
                              size: AppSpacing.ap30.w,
                            ),
                          ),
                          onChanged: (String? val) {
                            _loginController.setPasswordLoginEvent(val ?? "");
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
                    onPressed: _loginController.isAllFieldsValid.value == true
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
                      onPressed: () {
                        initForgetPasswordModel();
                        Get.toNamed(Routes.forgetPasswordRoute);
                      },
                      child: Text(
                        AppStrings.forgetPassword,
                        style: themeData.textTheme.titleSmall,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        initRegisterModel();
                        Get.offNamed(Routes.registerRoute);
                      },
                      child: Text(
                        AppStrings.notHaveAccount,
                        style: themeData.textTheme.titleSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
