import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/resources/font_manger.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/util/get_device_type.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    required this.label,
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

  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType keyBoardType;
  final String label;
  final FocusNode? nextNode;
  final bool obscureText;
  final IconData prefixIcon;
  final Widget? suffixWidget;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  void dispose() {
    try {
      widget.focusNode?.dispose();
    } catch (e) {}
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: context.textTheme.labelMedium,
      keyboardType: widget.keyBoardType,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) => widget.nextNode?.requestFocus(),
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.ap8),
            child: Icon(
              widget.prefixIcon,
              size: FontSize.s30,
            ),
          ),
          suffixIcon: Device.get().isTablet
              ? Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: widget.suffixWidget,
                )
              : widget.suffixWidget,
          label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.ap8),
            child: Text(widget.label),
          ),
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}
