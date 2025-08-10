import 'package:flutter/material.dart';

extension BuildContextEntension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  bool get isTablet => MediaQuery.of(this).size.width >= 600;
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get appColors => Theme.of(this).colorScheme;
  Color get activeColor => Color(0xff01e676);
  Color get pendingColor => Color(0xffff9811);
  Color get completedColor => Colors.blue;
}
