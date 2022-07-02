import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/color_manager.dart';
import 'package:ms_store/core/resources/font_manger.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:ms_store/core/resources/styles_manger.dart';
import 'package:ms_store/presentation/base/user_data/user_data_controller.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';
import '../../../app/components/common/input_field.dart';
import '../../../app/components/common/phone_form_field.dart';
import '../../../core/resources/values_manager.dart';
import '../controller/contact_us_controller.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  late final ContactUsController _contactUsController;
  late final UserDataController _userDataController;
  late final TextEditingController _textUserNameEditingController;
  late final TextEditingController _textEmailEditingController;
  late final TextEditingController _textPhoneEditingController;

  late final FocusNode _emailNode;
  late final FocusNode _phoneNode;
  late final FocusNode _subjectNode;
  late final FocusNode _messageNode;

  @override
  void initState() {
    _contactUsController = Get.find();
    _userDataController = Get.find();
    _emailNode = FocusNode();
    _phoneNode = FocusNode();
    _subjectNode = FocusNode();
    _messageNode = FocusNode();
    _textEmailEditingController = TextEditingController();
    _textUserNameEditingController = TextEditingController();
    _textPhoneEditingController = TextEditingController();
    _textEmailEditingController.text =
        _userDataController.userModel.value?.email ?? "";
    _textUserNameEditingController.text =
        _userDataController.userModel.value?.userName ?? "";
    _textPhoneEditingController.text =
        _userDataController.userModel.value?.phone ?? "";

    if (_textEmailEditingController.text.isNotEmpty) {
      _contactUsController.setEmailEvent(_textEmailEditingController.text);
    }
    if (_textUserNameEditingController.text.isNotEmpty) {
      _contactUsController.setUserNameEvent(_textEmailEditingController.text);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.contactUsTitle,
          style: context.textTheme.labelLarge,
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.ap12),
        child: Column(
          children: [
            Text(
              AppStrings.getInTouch,
              style: getRegularStyle(
                fontSize: FontSize.s40,
                color: ColorManager.textColor,
              ),
            ),
            const SizedBox(height: AppSpacing.ap30),
            Obx(
              () => InputFieldAboveTitle(
                  controller: _textUserNameEditingController,
                  keyBoardType: TextInputType.name,
                  nextNode: _emailNode,
                  label: "${AppStrings.userName} *",
                  errorText: _contactUsController.alertUserValid.value,
                  onChanged: (String? val) {
                    _contactUsController.setUserNameEvent(val ?? "");
                  }),
            ),
            const SizedBox(height: AppSpacing.ap30),
            Obx(
              () => InputFieldAboveTitle(
                controller: _textEmailEditingController,
                keyBoardType: TextInputType.emailAddress,
                focusNode: _emailNode,
                nextNode: _phoneNode,
                label: "${AppStrings.emailTitle} *",
                errorText: _contactUsController.alertEmailValid.value,
                onChanged: (String? val) {
                  _contactUsController.setEmailEvent(val ?? "");
                },
              ),
            ),
            const SizedBox(height: AppSpacing.ap30),
            BuildPhoneFormFieldAboveText(
              phoneNode: _phoneNode,
              nextNode: _subjectNode,
              onChanged: (PhoneNumber? p) {
                _contactUsController.setAlertPhoneEvent(p);
              },
            ),
            const SizedBox(height: AppSpacing.ap30),
            Obx(
              () => InputFieldAboveTitle(
                keyBoardType: TextInputType.text,
                focusNode: _subjectNode,
                nextNode: _messageNode,
                label: "${AppStrings.subject} *",
                errorText: _contactUsController.alertSubjectValid.value,
                onChanged: (String? val) {
                  _contactUsController.setAlertSubjectEvent(val ?? "");
                },
              ),
            ),
            const SizedBox(height: AppSpacing.ap30),
            Obx(
              () => InputFieldExpanded(
                keyBoardType: TextInputType.multiline,
                focusNode: _messageNode,
                label: "${AppStrings.message} *",
                errorText: _contactUsController.alertMessageValid.value,
                onChanged: (String? val) {
                  _contactUsController.setAlertMessageEvent(val ?? "");
                },
              ),
            ),
            const SizedBox(height: AppSpacing.ap30),
            Obx(
              () => ElevatedButton(
                  onPressed: _contactUsController.isAllFieldsValid.value &&
                          !_contactUsController.isButtonClicked.value
                      ? () {
                          _contactUsController.onSubmit();
                        }
                      : null,
                  child: Text(AppStrings.submit)),
            ),
            const SizedBox(height: AppSpacing.ap12),
            Obx(() => BuildCondition(
                  condition: _contactUsController.isButtonClicked.value,
                  builder: (context) {
                    return const LinearProgressIndicator(
                      minHeight: AppSpacing.ap8,
                      backgroundColor: ColorManager.textColor,
                      valueColor:
                          AlwaysStoppedAnimation(ColorManager.darkColor),
                    );
                  },
                  fallback: (_) => const SizedBox(),
                )),
          ],
        ),
      )),
    );
  }
}
