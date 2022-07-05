import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ms_store/app/resources/strings_manager.dart';
import 'package:tbib_phone_form_field/tbib_phone_form_field.dart';

import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manger.dart';
import '../../../app/resources/styles_manger.dart';
import '../../../app/resources/values_manager.dart';

class BuildPhoneFormField extends StatefulWidget {
  final FocusNode phoneNode;
  final FocusNode? nextNode;
  final ValueChanged<PhoneNumber?>? onChanged;
  final bool required;
  final PhoneController? phoneController;
  final Widget? suffix;

  const BuildPhoneFormField(
      {Key? key,
      required this.phoneNode,
      this.nextNode,
      required this.onChanged,
      this.required = false,
      this.phoneController,
      this.suffix})
      : super(key: key);

  @override
  State<BuildPhoneFormField> createState() => _BuildPhoneFormFieldState();
}

class _BuildPhoneFormFieldState extends State<BuildPhoneFormField> {
  @override
  void dispose() {
    widget.phoneNode.dispose();
    widget.nextNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhoneFormField(
      controller: widget.phoneController,
      showDropDownIcon: false,
      defaultCountry: IsoCode.EG, // default
      countryCodeStyle: context.textTheme.labelMedium,
      onSubmitted: (String? _) {
        widget.nextNode?.requestFocus();
      },
      focusNode: widget.phoneNode,
      decoration: InputDecoration(
        suffix: widget.suffix,
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.ap8),
          child: widget.required
              ? Text("${AppStrings.phone} *")
              : Text(AppStrings.phone),
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
      validator: widget.required
          ? PhoneValidator.compose([
              PhoneValidator.required(),
              PhoneValidator.validMobile(),
            ])
          : PhoneValidator.compose([
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
  final bool required;
  final PhoneController? phoneController;

  const BuildPhoneFormFieldAboveText(
      {Key? key,
      required this.phoneNode,
      required this.nextNode,
      required this.onChanged,
      this.required = false,
      this.phoneController})
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
          widget.required ? "${AppStrings.phone} *" : AppStrings.phone,
          style:
              getMediumStyle(fontSize: FontSize.s16, color: ColorManager.grey),
        ),
        const SizedBox(
          height: AppSize.ap12,
        ),
        PhoneFormField(
          controller: widget.phoneController,
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
          validator: widget.required
              ? PhoneValidator.compose([
                  PhoneValidator.required(),
                  PhoneValidator.validMobile(),
                ])
              : PhoneValidator.compose([
                  PhoneValidator.validMobile(),
                ]),
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
