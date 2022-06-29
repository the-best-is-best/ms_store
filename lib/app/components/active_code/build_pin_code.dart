import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/resources/color_manager.dart';
import '../../../core/resources/font_manger.dart';
import '../../../core/resources/icons_manger.dart';
import '../../../core/resources/values_manager.dart';

class BuildPinCodeTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  const BuildPinCodeTextField(
      {Key? key, required this.onChanged, this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Icon(
            IconsManger.pin,
            size: FontSize.s30,
            color: ColorManager.darkColor,
          ),
        ),
        Expanded(
          flex: 6,
          child: PinCodeTextField(
            pinTheme: PinTheme.defaults(
              fieldHeight: 40,
              fieldWidth: 40,
              shape: PinCodeFieldShape.box,
              errorBorderColor: ColorManager.error,
              selectedColor: ColorManager.primaryColor,
              inactiveColor: ColorManager.grey,
              borderRadius: BorderRadius.circular(AppSpacing.ap14),
              borderWidth: AppSpacing.ap1_5,
            ),
            length: 5,
            textStyle: context.textTheme.labelMedium,
            keyboardType: TextInputType.number,
            obscureText: false,
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),
            onChanged: onChanged,
            appContext: context,
            onSubmitted: onSubmitted,
          ),
        ),
        const SizedBox(
          width: AppSize.ap30,
        ),
      ],
    );
  }
}
