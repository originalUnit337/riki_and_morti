import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightAppTheme {
    return ThemeData(brightness: Brightness.light);
  }

  static ThemeData get darkAppTheme {
    return ThemeData(brightness: Brightness.dark);
  }
}
