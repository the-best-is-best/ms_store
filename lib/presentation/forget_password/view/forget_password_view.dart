import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../view_model/forget_password_controller.dart';

import '../../../app/components.dart';
import '../../../app/di.dart';
import '../../resources/icons_manger.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final ForgetPasswordViewGetX _forgetPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _forgetPasswordController = Get.find();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    //Get.delete<LoginViewModelGetX>();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      )),
      body: Obx(() {
        return _forgetPasswordController.flowState.value != null
            ? _forgetPasswordController.flowState.value!.getScreenWidget(
                _getContentWidget(),
                retryActionFunction: _forgetPasswordController.flowState.value
                            ?.getStateRendererType() ==
                        StateRendererType.POPUP_CHECK_EMAIL_STATE
                    ? () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          initResetPasswordModel();
                          Get.offNamedUntil(
                              Routes.resetPasswordRoute, (route) => false,
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
                  Obx(() {
                    return InputField(
                      themeData: themeData,
                      controller: _emailController,
                      keyBoardType: TextInputType.emailAddress,
                      prefixIcon: IconsManger.email,
                      label: "${AppStrings.emailTitle} *",
                      errorText:
                          _forgetPasswordController.alertEmailValid.value,
                      onChanged: (String? val) {
                        _forgetPasswordController.setEmailEvent(val ?? "");
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
                      onPressed: _forgetPasswordController
                              .isAllFieldsValid.value
                          ? () {
                              _forgetPasswordController.forgetPasswordEvent();
                            }
                          : null,
                      child: Text(AppStrings.forgetPassword),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}