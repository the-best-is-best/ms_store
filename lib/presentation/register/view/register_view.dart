import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../../resources/routes_manger.dart';
import '../view_model/register_controller.dart';

import '../../../app/components.dart';
import '../../../resources/icons_manger.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;

  late final GlobalKey<FormState> _formKey;
  late final RegisterController _registerController;

  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;
  late final FocusNode _passwordAgainNode;

  @override
  void initState() {
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _registerController = Get.find();
    _passwordNode = FocusNode();
    _emailNode = FocusNode();
    _passwordAgainNode = FocusNode();
    // _controllerGoogle = LoadingSignButtonController();
    // _controllerFacebook = LoadingSignButtonController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(GetPlatform.isIOS ? CupertinoIcons.back : Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      )),
      body: Obx(() {
        return _registerController.flowState.value != null
            ? _registerController.flowState.value!.getScreenWidget(
                _getContentWidget(),
                retryActionFunction: _registerController.flowState.value
                            ?.getStateRendererType() ==
                        StateRendererType.POPUP_CHECK_EMAIL_STATE
                    ? () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          initActiveEmailModel();
                          Get.offNamedUntil(
                              Routes.activeEmailRoute, (route) => false,
                              arguments: {'email': _emailController.text});
                        });
                      }
                    : null)
            : _getContentWidget();
      }),
    );
  }

  Widget _getContentWidget() {
    final ThemeData themeData = Theme.of(context);
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
                Obx(
                  () => InputField(
                      themeData: themeData,
                      keyBoardType: TextInputType.name,
                      nextNode: _emailNode,
                      prefixIcon: IconsManger.user,
                      label: "${AppStrings.userName} *",
                      errorText: _registerController.alertUserValid.value,
                      onChanged: (String? val) {
                        _registerController.setUserNameEvent(val ?? "");
                      }),
                ),
                SizedBox(
                  height: AppSpacing.ap30.h,
                ),
                Obx(
                  () => InputField(
                    themeData: themeData,
                    controller: _emailController,
                    keyBoardType: TextInputType.emailAddress,
                    obscureText: _registerController.obscure.value,
                    focusNode: _emailNode,
                    nextNode: _passwordNode,
                    prefixIcon: IconsManger.email,
                    label: "${AppStrings.emailTitle} *",
                    errorText: _registerController.alertEmailValid.value,
                    onChanged: (String? val) {
                      _registerController.setEmailEvent(val ?? "");
                    },
                  ),
                ),
                SizedBox(
                  height: AppSpacing.ap30.h,
                ),
                Obx(() {
                  return InputField(
                    themeData: themeData,
                    keyBoardType: TextInputType.visiblePassword,
                    focusNode: _passwordNode,
                    nextNode: _passwordAgainNode,
                    obscureText: _registerController.obscure.value,
                    prefixIcon: IconsManger.password,
                    suffixWidget: IconButton(
                      onPressed: () {
                        _registerController.changeObscureEvent();
                      },
                      icon: Icon(
                        !_registerController.obscure.value
                            ? IconsManger.visibility
                            : IconsManger.visibilityOff,
                        size: AppSpacing.ap30.w,
                      ),
                    ),
                    label: "${AppStrings.password} *",
                    errorText: _registerController.alertPasswordValid.value,
                    onChanged: (String? val) {
                      _registerController.setPasswordEvent(val ?? "");
                    },
                  );
                }),
                SizedBox(
                  height: AppSpacing.ap30.h,
                ),
                Obx(() {
                  return InputField(
                    themeData: themeData,
                    keyBoardType: TextInputType.visiblePassword,
                    obscureText: _registerController.obscureAgain.value,
                    focusNode: _passwordAgainNode,
                    prefixIcon: IconsManger.password,
                    label: "${AppStrings.passwordAgain} *",
                    errorText:
                        _registerController.alertPasswordAgainValid.value,
                    suffixWidget: IconButton(
                      onPressed: () {
                        _registerController.changeObscureAgainEvent();
                      },
                      icon: Icon(
                        !_registerController.obscureAgain.value
                            ? IconsManger.visibility
                            : IconsManger.visibilityOff,
                        size: AppSpacing.ap30.w,
                      ),
                    ),
                    onChanged: (String? val) {
                      _registerController.setPasswordAgainEvent(val ?? "");
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
                    onPressed: _registerController.isAllFieldsValid.value
                        ? () {
                            _registerController.registerEvent();
                          }
                        : null,
                    child: Text(AppStrings.registerTitle),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Expanded(
                //   child: TextButton(
                //     onPressed: () {
                //       Get.toNamed(Routes.forgetPasswordRoute);
                //     },
                //     child: Text(
                //       AppStrings.forgetPassword,
                //       style: themeData.textTheme.titleSmall,
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: TextButton(
                //     onPressed: () {},
                //     child: Text(
                //       AppStrings.notHaveAccount,
                //       style: themeData.textTheme.titleSmall,
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
