import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ms_store/core/util/get_device_type.dart';

import '../core/resources/values_manager.dart';

Image logo({double? logoHeight, required bool isDark}) {
  return Image(
    image: AssetImage(!isDark
        ? "assets/images/logo_in_light.png"
        : "assets/images/logo_in_dark.png"),
    fit: BoxFit.cover,
    height: logoHeight ?? 100,
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
          suffixIcon: Device.get().isTablet
              ? Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: widget.suffixWidget,
                )
              : widget.suffixWidget,
          label: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.ap8.w),
            child: Text(widget.label),
          ),
          errorText: widget.errorText),
      onChanged: widget.onChanged,
    );
  }
}

// Build animated item (helper for all examples)

/// Wrap Ui item with animation & padding
Widget Function(
  BuildContext context,
  int index,
  Animation<double> animation,
) animationItemBuilder(
  Widget Function(int index) child, {
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child(index),
            ),
          ),
        );

Widget Function(
  BuildContext context,
  Animation<double> animation,
) animationBuilder(
  Widget child, {
  double xOffset = 0,
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(xOffset, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        );

class HorizontalItem extends StatelessWidget {
  const HorizontalItem({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        width: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Material(
            color: Colors.white,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      );
}
