import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../app/components.dart';
import '../../../app/components/common/build_logo.dart';
import '../../../app/components/common/input_field.dart';
import '../../../app/di.dart';
import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../view_model/forget_password_controller.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  late final ForgetPasswordViewGetX _forgetPasswordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();

    _forgetPasswordController = Get.find();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const ButtonBack()),
      body: Obx(() {
        return _forgetPasswordController.flowState.value != null
            ? _forgetPasswordController.flowState.value!.getScreenWidget(
                _GetContentWidget(
                    forgetPasswordController: _forgetPasswordController,
                    emailController: _emailController),
                retryActionFunction: _forgetPasswordController.flowState.value
                            ?.getStateRendererType() ==
                        StateRendererType.POPUP_CHECK_EMAIL_STATE
                    ? () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          initResetPasswordModel();
                          Get.offNamedUntil(
                              Routes.resetPasswordRoute, (route) => false,
                              arguments: {
                                'email': _emailController.text.toLowerCase()
                              });
                        });
                      }
                    : null)
            : _GetContentWidget(
                forgetPasswordController: _forgetPasswordController,
                emailController: _emailController,
              );
      }),
    );
  }
}

class _GetContentWidget extends StatefulWidget {
  final ForgetPasswordViewGetX forgetPasswordController;
  final TextEditingController emailController;

  const _GetContentWidget(
      {Key? key,
      required this.forgetPasswordController,
      required this.emailController})
      : super(key: key);

  @override
  State<_GetContentWidget> createState() => _GetContentWidgetState();
}

class _GetContentWidgetState extends State<_GetContentWidget> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

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
                  Obx(() {
                    return InputField(
                      controller: widget.emailController,
                      keyBoardType: TextInputType.emailAddress,
                      prefixIcon: IconsManger.email,
                      label: "${AppStrings.emailTitle} *",
                      errorText:
                          widget.forgetPasswordController.alertEmailValid.value,
                      onChanged: (String? val) {
                        widget.forgetPasswordController
                            .setEmailEvent(val?.toLowerCase() ?? "");
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: AppSpacing.ap30,
              ),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          widget.forgetPasswordController.isAllFieldsValid.value
                              ? () {
                                  widget.forgetPasswordController
                                      .forgetPasswordEvent();
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
