import 'package:flutter/material.dart';

import 'app_font.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstant.fontAlexandria,
    color: color,
    fontWeight: fontWeight,
  );
}

// light style
TextStyle getLightStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

// regular style
TextStyle getRegularStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style
TextStyle getMediumStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}
