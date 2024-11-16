import 'package:flutter/material.dart';

class AppConfig {
  // Paddings
  static const EdgeInsets generalPadding = EdgeInsets.all(16.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0);
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0);

  // Button Heights and Widths
  static const double buttonHeight = 50.0;
  static const double buttonWidth = double.infinity;

  // Font Sizes
  static const double headingFontSize = 24.0;
  static const double subheadingFontSize = 18.0;
  static const double bodyFontSize = 14.0;

  // Border Radius
  static const double borderRadius = 15.0;
  static const BorderRadiusGeometry buttonBorderRadius = BorderRadius.all(Radius.circular(borderRadius));

  // Miscellaneous
  static const double spaceBetween = 10.0;

  // Image Size
  static const double imageSize = 250.0;
}
