import 'package:flutter/widgets.dart';
import '../../core/resources/font_manger.dart';

TextStyle _getTextStyle(
    {required double fontSize,
    required FontWeight fontWeight,
    required Color color}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}

// light

TextStyle getLightStyle({
  //double fontSize = FontSize.s12,
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWeightManager.light, color: color);
}

// regular

TextStyle getRegularStyle({
  //double fontSize = FontSize.s14,
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWeightManager.regular, color: color);
}

// medium

TextStyle getMediumStyle({
  //double fontSize = FontSize.s16,
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWeightManager.medium, color: color);
}

// semi bold

TextStyle getSemiBoldStyle({
  // double fontSize = FontSize.s18,
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWeightManager.semiBold, color: color);
}

// bold

TextStyle getBoldStyle({
  // double fontSize = FontSize.s20,
  required double fontSize,
  required Color color,
}) {
  return _getTextStyle(
      fontSize: fontSize, fontWeight: FontWeightManager.bold, color: color);
}
