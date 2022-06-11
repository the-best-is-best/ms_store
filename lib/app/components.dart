import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/values_manager.dart';

Image logo({double? logoHeight, required bool isDark}) {
  return Image(
    image: AssetImage(!isDark
        ? "assets/images/logo_in_light.png"
        : "assets/images/logo_in_dark.png"),
    fit: BoxFit.cover,
    height: logoHeight ?? 150.h,
  );
}

Future<void> waitStateChanged({int? duration}) async {
  await Future.delayed(Duration(milliseconds: duration ?? 1));
}

class InputField extends StatefulWidget {
  final String label;
  final String? errorText;
  final ThemeData themeData;
  final TextEditingController? controller;
  final TextInputType keyBoardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final Function(String)? onChanged;
  final IconData prefixIcon;
  final Widget? suffixWidget;

  const InputField({
    Key? key,
    required this.label,
    required this.themeData,
    required this.keyBoardType,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.nextNode,
    this.errorText,
    this.onChanged,
    required this.prefixIcon,
    this.suffixWidget,
  }) : super(key: key);
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void dispose() {
    widget.focusNode?.dispose();
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: widget.themeData.textTheme.labelMedium,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.nextNode?.requestFocus(),
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.ap8.w),
            child: Icon(
              widget.prefixIcon,
              size: AppSize.ap30.sp,
            ),
          ),
          suffixIcon: widget.suffixWidget,
          label: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.ap8.w),
            child: Text(widget.label),
          ),
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}
