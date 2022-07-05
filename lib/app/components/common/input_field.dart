import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/resources/color_manager.dart';
import '../../../app/resources/font_manger.dart';
import '../../../app/resources/styles_manger.dart';
import '../../../app/resources/values_manager.dart';
import '../../../app/util/get_device_type.dart';

class InputField extends StatefulWidget {
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;

  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType keyBoardType;
  final String label;
  final FocusNode? nextNode;
  final bool obscureText;
  final IconData prefixIcon;
  final Widget? suffixWidget;
  final bool? enable;

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
    this.onEditingComplete,
    this.enable = true,
  }) : super(key: key);

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
      enabled: widget.enable,
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
      onEditingComplete: widget.onEditingComplete,
    );
  }
}

class InputFieldAboveTitle extends StatefulWidget {
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType keyBoardType;
  final String label;
  final FocusNode? nextNode;
  final bool obscureText;

  final int? maxLine;
  const InputFieldAboveTitle({
    Key? key,
    required this.label,
    required this.keyBoardType,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.nextNode,
    this.errorText,
    this.onChanged,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  State<InputFieldAboveTitle> createState() => _InputFieldAboveTitleState();
}

class _InputFieldAboveTitleState extends State<InputFieldAboveTitle> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style:
              getMediumStyle(fontSize: FontSize.s16, color: ColorManager.grey),
        ),
        const SizedBox(
          height: AppSize.ap12,
        ),
        TextFormField(
          maxLines: widget.maxLine,
          controller: widget.controller,
          style: context.textTheme.labelMedium,
          keyboardType: widget.keyBoardType,
          obscureText: widget.obscureText,
          focusNode: widget.focusNode,
          onFieldSubmitted: (_) => widget.nextNode?.requestFocus(),
          decoration: InputDecoration(errorText: widget.errorText),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

class InputFieldExpanded extends StatefulWidget {
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType keyBoardType;
  final String label;
  final FocusNode? nextNode;
  final bool obscureText;
  final Widget? suffixWidget;
  final bool expands;

  const InputFieldExpanded({
    Key? key,
    required this.label,
    required this.keyBoardType,
    this.controller,
    this.obscureText = false,
    this.focusNode,
    this.nextNode,
    this.errorText,
    this.onChanged,
    this.suffixWidget,
    this.expands = false,
  }) : super(key: key);

  @override
  State<InputFieldExpanded> createState() => _InputFieldExpanded();
}

class _InputFieldExpanded extends State<InputFieldExpanded> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style:
              getMediumStyle(fontSize: FontSize.s16, color: ColorManager.grey),
        ),
        const SizedBox(
          height: AppSize.ap12,
        ),
        TextFormField(
          minLines: (Get.height * .007).toInt(),
          maxLines: (Get.height * .007).toInt(),
          controller: widget.controller,
          style: context.textTheme.labelMedium,
          keyboardType: TextInputType.multiline,
          obscureText: widget.obscureText,
          focusNode: widget.focusNode,
          onFieldSubmitted: (_) => widget.nextNode?.requestFocus(),
          decoration: InputDecoration(errorText: widget.errorText),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
