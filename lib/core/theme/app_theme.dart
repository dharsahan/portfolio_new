import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    // fontFamily: 'MyCustomFont', // Uncomment this after adding the font
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textColor),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.textColor),
    ),
  );
}
