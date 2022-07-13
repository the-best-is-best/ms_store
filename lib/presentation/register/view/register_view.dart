import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/font_manger.dart';

import '../../../app/components.dart';
import '../../../app/components/common/build_logo.dart';
import '../../../app/components/common/input_field.dart';
import '../../../app/components/products/privacy_policy.dart';
import '../../../app/di.dart';
import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/routes_manger.dart';
import '../../../app/resources/strings_manager.dart';
import '../../../app/resources/values_manager.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../view_model/register_controller.dart';

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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const ButtonBack()),
      body: Obx(() {
        return _registerController.flowState.value != null
            ? _registerController.flowState.value!.getScreenWidget(
                _GetContentWidget(
                    formKey: _formKey,
                    emailNode: _emailNode,
                    registerController: _registerController,
                    emailController: _emailController,
                    passwordNode: _passwordNode,
                    passwordAgainNode: _passwordAgainNode,
                    context: context),
                retryActionFunction: _registerController.flowState.value
                            ?.getStateRendererType() ==
                        StateRendererType.POPUP_CHECK_EMAIL_STATE
                    ? () {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          initActiveEmailModel();
                          Get.offNamedUntil(
                              Routes.activeEmailRoute, (route) => false,
                              arguments: {
                                'email': _emailController.text.toLowerCase()
                              });
                        });
                      }
                    : null)
            : _GetContentWidget(
                formKey: _formKey,
                emailNode: _emailNode,
                registerController: _registerController,
                emailController: _emailController,
                passwordNode: _passwordNode,
                passwordAgainNode: _passwordAgainNode,
                context: context);
      }),
    );
  }
}

class _GetContentWidget extends StatelessWidget {
  const _GetContentWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
    required FocusNode emailNode,
    required RegisterController registerController,
    required TextEditingController emailController,
    required FocusNode passwordNode,
    required FocusNode passwordAgainNode,
    required this.context,
  })  : _formKey = formKey,
        _emailNode = emailNode,
        _registerController = registerController,
        _emailController = emailController,
        _passwordNode = passwordNode,
        _passwordAgainNode = passwordAgainNode,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final FocusNode _emailNode;
  final RegisterController _registerController;
  final TextEditingController _emailController;
  final FocusNode _passwordNode;
  final FocusNode _passwordAgainNode;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
          top: AppSpacing.ap100, left: AppSpacing.ap14, right: AppSpacing.ap14),
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
                Obx(
                  () => InputField(
                      keyBoardType: TextInputType.name,
                      nextNode: _emailNode,
                      prefixIcon: IconsManger.user,
                      label: "${AppStrings.userName} *",
                      errorText: _registerController.alertUserValid.value,
                      onChanged: (String? val) {
                        _registerController.setUserNameEvent(val ?? "");
                      }),
                ),
                const SizedBox(height: AppSpacing.ap30),
                Obx(
                  () => InputField(
                    controller: _emailController,
                    keyBoardType: TextInputType.emailAddress,
                    focusNode: _emailNode,
                    nextNode: _passwordNode,
                    prefixIcon: IconsManger.email,
                    label: "${AppStrings.emailTitle} *",
                    errorText: _registerController.alertEmailValid.value,
                    onChanged: (String? val) {
                      _registerController
                          .setEmailEvent(val?.toLowerCase() ?? "");
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.ap30),
                Obx(() {
                  return InputField(
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
                        size: FontSize.s30,
                      ),
                    ),
                    label: "${AppStrings.password} *",
                    errorText: _registerController.alertPasswordValid.value,
                    onChanged: (String? val) {
                      _registerController.setPasswordEvent(val ?? "");
                    },
                  );
                }),
                const SizedBox(height: AppSpacing.ap30),
                Obx(() {
                  return InputField(
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
                        size: FontSize.s30,
                      ),
                    ),
                    onChanged: (String? val) {
                      _registerController.setPasswordAgainEvent(val ?? "");
                    },
                  );
                }),
                PrivacyAndTerms(
                    onChanged: (value) {
                      _registerController.isPrivacyPolicyChecked(value);
                    },
                    registerController: _registerController),
              ],
            ),
            const SizedBox(height: AppSpacing.ap30),
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
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      initForgetPasswordModel();
                      Get.toNamed(Routes.forgetPasswordRoute);
                    },
                    child: Text(
                      AppStrings.forgetPassword,
                      style: context.textTheme.labelSmall,
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      initLoginModel();
                      Get.toNamed(Routes.loginRoute,
                          arguments: {'canBack': true});
                    },
                    child: Text(
                      AppStrings.iHaveAccount,
                      style: context.textTheme.labelSmall,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
