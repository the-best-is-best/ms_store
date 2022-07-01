import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/core/resources/strings_manager.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';

import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manger.dart';
import '../../../core/resources/styles_manger.dart';
import '../../../core/resources/values_manager.dart';

class BuildPhoneFormField extends StatefulWidget {
  final FocusNode phoneNode;
  final FocusNode nextNode;
  final ValueChanged<PhoneNumber?>? onChanged;

  const BuildPhoneFormField(
      {Key? key,
      required this.phoneNode,
      required this.nextNode,
      required this.onChanged})
      : super(key: key);

  @override
  State<BuildPhoneFormField> createState() => _BuildPhoneFormFieldState();
}

class _BuildPhoneFormFieldState extends State<BuildPhoneFormField> {
  @override
  void dispose() {
    widget.phoneNode.dispose();
    widget.nextNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      showDropDownIcon: true,
      defaultCountry: IsoCode.EG, // default
      countryCodeStyle: context.textTheme.labelMedium,
      onSubmitted: (String? _) {
        widget.nextNode.requestFocus();
      },
      focusNode: widget.phoneNode,
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.ap8),
          child: Text("${AppStrings.phone} *"),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: AppSpacing.ap1_5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSpacing.ap8),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: AppSpacing.ap1_5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSpacing.ap8),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: AppSpacing.ap1_5,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppSpacing.ap8),
          ),
        ),
      ),
      validator: PhoneValidator.compose([
        PhoneValidator.required(),
        PhoneValidator.validMobile(),
      ]), // default PhoneValidator.valid()
      countrySelectorNavigator: const CountrySelectorNavigator.bottomSheet(),
      showFlagInInput: true, // default
      flagSize: FontSize.s16, // default

      autofillHints: const [AutofillHints.telephoneNumber], // default to null
      enabled: true, // default
      autovalidateMode: AutovalidateMode.onUserInteraction, // default
      onChanged: widget.onChanged, // default null
    );
  }
}

class BuildPhoneFormFieldAboveText extends StatefulWidget {
  final FocusNode phoneNode;
  final FocusNode nextNode;
  final ValueChanged<PhoneNumber?>? onChanged;

  const BuildPhoneFormFieldAboveText(
      {Key? key,
      required this.phoneNode,
      required this.nextNode,
      required this.onChanged})
      : super(key: key);

  @override
  State<BuildPhoneFormFieldAboveText> createState() =>
      _BuildPhoneFormFieldAboveText();
}

class _BuildPhoneFormFieldAboveText
    extends State<BuildPhoneFormFieldAboveText> {
  @override
  void dispose() {
    widget.phoneNode.dispose();
    widget.nextNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppStrings.phone} *",
          style:
              getMediumStyle(fontSize: FontSize.s16, color: ColorManager.grey),
        ),
        const SizedBox(
          height: AppSize.ap12,
        ),
        PhoneFormField(
          showDropDownIcon: true,
          defaultCountry: IsoCode.EG, // default
          countryCodeStyle: context.textTheme.labelMedium,
          onSubmitted: (String? _) {
            widget.nextNode.requestFocus();
          },
          focusNode: widget.phoneNode,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: AppSpacing.ap1_5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(AppSpacing.ap8),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: AppSpacing.ap1_5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(AppSpacing.ap8),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: AppSpacing.ap1_5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(AppSpacing.ap8),
              ),
            ),
          ),
          validator: PhoneValidator.compose([
            PhoneValidator.required(),
            PhoneValidator.validMobile(),
          ]), // default PhoneValidator.valid()
          countrySelectorNavigator:
              const CountrySelectorNavigator.bottomSheet(),
          showFlagInInput: true, // default
          flagSize: FontSize.s16, // default

          autofillHints: const [
            AutofillHints.telephoneNumber
          ], // default to null
          enabled: true, // default
          autovalidateMode: AutovalidateMode.onUserInteraction, // default
          onChanged: widget.onChanged, // default null
        ),
      ],
    );
  }
}
