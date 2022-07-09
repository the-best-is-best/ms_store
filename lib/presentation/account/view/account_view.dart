import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/components/common/input_field.dart';
import 'package:ms_store/app/components/common/phone_form_field.dart';
import 'package:ms_store/app/resources/color_manager.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:ms_store/presentation/account/controller/account_controller.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:ms_store/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';
import '../../../app/resources/font_manger.dart';
import '../../../app/resources/icons_manger.dart';
import '../../../app/resources/values_manager.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late final GlobalKey<FormState> _formKey;
  late final AccountController _accountController;
  late final UserDataController _userDataController;

  late final TextEditingController _textEmailController;
  late final TextEditingController _textUserController;
  late final PhoneController _textPhoneController;

  late final FocusNode _emailNode;
  late final FocusNode _phoneNode;
  late final FocusNode _passwordAgainNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _accountController = Get.find();
    _userDataController = Get.find();
    _textEmailController = TextEditingController();
    _textUserController = TextEditingController();

    _textEmailController.text =
        _userDataController.userModel.value?.email ?? "";
    _textUserController.text =
        _userDataController.userModel.value?.userName ?? "";
    List<String>? phoneData =
        _userDataController.userModel.value?.phone.split('-');
    if (phoneData != null && phoneData.length == 2) {
      _textPhoneController = PhoneController(
          PhoneNumber.fromCountryCode(phoneData[0], phoneData[1]));
    } else {
      _textPhoneController =
          PhoneController(const PhoneNumber(isoCode: IsoCode.EG, nsn: ""));
    }

    _userDataController.userModel.value?.phone ?? "";
    _emailNode = FocusNode();
    _phoneNode = FocusNode();

    _passwordAgainNode = FocusNode();

    _accountController.setEmailEvent(_textEmailController.text);
    _accountController.setUserNameEvent(_textUserController.text);
    _accountController.setAlertPhoneEvent(_textPhoneController.value);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.updateProfile,
          style: context.textTheme.labelLarge,
        ),
        leading: const BackButton(),
      ),
      body: Obx(() => _accountController.flowState.value != null
          ? _accountController.flowState.value!.getScreenWidget(_GetContentPage(
              formKey: _formKey,
              textUserController: _textUserController,
              emailNode: _emailNode,
              accountController: _accountController,
              textEmailController: _textEmailController,
              phoneNode: _phoneNode,
              textPhoneController: _textPhoneController,
              passwordAgainNode: _passwordAgainNode))
          : _GetContentPage(
              formKey: _formKey,
              textUserController: _textUserController,
              emailNode: _emailNode,
              accountController: _accountController,
              textEmailController: _textEmailController,
              phoneNode: _phoneNode,
              textPhoneController: _textPhoneController,
              passwordAgainNode: _passwordAgainNode)),
    );
  }
}

class _GetContentPage extends StatelessWidget {
  const _GetContentPage({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController textUserController,
    required FocusNode emailNode,
    required AccountController accountController,
    required TextEditingController textEmailController,
    required FocusNode phoneNode,
    required PhoneController textPhoneController,
    required FocusNode passwordAgainNode,
  })  : _formKey = formKey,
        _textUserController = textUserController,
        _emailNode = emailNode,
        _accountController = accountController,
        _textEmailController = textEmailController,
        _phoneNode = phoneNode,
        _textPhoneController = textPhoneController,
        _passwordAgainNode = passwordAgainNode,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _textUserController;
  final FocusNode _emailNode;
  final AccountController _accountController;
  final TextEditingController _textEmailController;
  final FocusNode _phoneNode;
  final PhoneController _textPhoneController;
  final FocusNode _passwordAgainNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: ElevatedButton(
                      child: const Text("Logout"),
                      onPressed: () {
                        _accountController.logout();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.red[200],
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Text(
                        AppStrings.noteUpdateProfile,
                        style: context.textTheme.labelMedium,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          controller: _textUserController,
                          keyBoardType: TextInputType.name,
                          nextNode: _emailNode,
                          label: AppStrings.userName,
                          prefixIcon: IconsManger.user,
                          errorText: _accountController.alertUserValid.value,
                          onChanged: (String? val) {
                            _accountController.setUserNameEvent(val ?? "");
                          },
                        ),
                        const SizedBox(height: AppSpacing.ap30),
                        Obx(
                          () => InputField(
                            enable: false,
                            controller: _textEmailController,
                            keyBoardType: TextInputType.emailAddress,
                            focusNode: _emailNode,
                            nextNode: _phoneNode,
                            prefixIcon: IconsManger.email,
                            label: "${AppStrings.emailTitle} *",
                            errorText: _accountController.alertEmailValid.value,
                            onChanged: (String? val) {
                              _accountController.setEmailEvent(val ?? "");
                            },
                          ),
                        ),
                        const SizedBox(height: AppSpacing.ap30),
                        BuildPhoneFormField(
                            phoneController: _textPhoneController,
                            phoneNode: _phoneNode,
                            onChanged: (PhoneNumber? p) {
                              _accountController.setAlertPhoneEvent(p);
                            },
                            suffix: SendCode(
                              accountController: _accountController,
                            )),
                        const SizedBox(height: AppSpacing.ap30),
                        Obx(() {
                          return InputField(
                            keyBoardType: TextInputType.visiblePassword,
                            nextNode: _passwordAgainNode,
                            obscureText: _accountController.obscure.value,
                            prefixIcon: IconsManger.password,
                            suffixWidget: IconButton(
                              onPressed: () {
                                _accountController.changeObscureEvent();
                              },
                              icon: Icon(
                                !_accountController.obscure.value
                                    ? IconsManger.visibility
                                    : IconsManger.visibilityOff,
                                size: FontSize.s30,
                              ),
                            ),
                            label: "${AppStrings.password} *",
                            errorText:
                                _accountController.alertPasswordValid.value,
                            onChanged: (String? val) {
                              _accountController.setPasswordEvent(val ?? "");
                            },
                          );
                        }),
                        const SizedBox(height: AppSpacing.ap30),
                        Obx(() {
                          return InputField(
                            keyBoardType: TextInputType.visiblePassword,
                            obscureText: _accountController.obscureAgain.value,
                            focusNode: _passwordAgainNode,
                            prefixIcon: IconsManger.password,
                            label: "${AppStrings.passwordAgain} *",
                            errorText: _accountController
                                .alertPasswordAgainValid.value,
                            suffixWidget: IconButton(
                              onPressed: () {
                                _accountController.changeObscureAgainEvent();
                              },
                              icon: Icon(
                                !_accountController.obscureAgain.value
                                    ? IconsManger.visibility
                                    : IconsManger.visibilityOff,
                                size: FontSize.s30,
                              ),
                            ),
                            onChanged: (String? val) {
                              _accountController
                                  .setPasswordAgainEvent(val ?? "");
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.ap30),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() => ElevatedButton(
                          onPressed: _accountController
                                      .isAllFieldsValid.value &&
                                  _accountController.loadingVerifyPhone.value ==
                                      false
                              ? () {
                                  _accountController.updateUserData();
                                }
                              : null,
                          child: Text(AppStrings.updateProfile),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SendCode extends StatefulWidget {
  final AccountController accountController;
  const SendCode({Key? key, required this.accountController}) : super(key: key);

  @override
  State<SendCode> createState() => _SendCodeState();
}

class _SendCodeState extends State<SendCode> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (widget.accountController.alertPhoneValid.value == true) {
          if (widget.accountController.loadingVerifyPhone.value == false) {
            if (widget.accountController.isVerifiedPhone.value == false) {
              return InkWell(
                onTap: () {
                  widget.accountController.verifyPhone();
                },
                child: Text(
                  AppStrings.sendCode,
                  style: context.textTheme.labelMedium!
                      .copyWith(color: ColorManager.primaryColor),
                ),
              );
            } else {
              return Icon(
                IconsManger.success,
                size: FontSize.s30,
                color: ColorManager.darkColor,
              );
            }
          } else {
            return const SizedBox(
              height: 20,
              width: 20,
              child:
                  CircularProgressIndicator(color: ColorManager.primaryColor),
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
