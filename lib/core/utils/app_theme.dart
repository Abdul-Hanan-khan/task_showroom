import 'package:flutter/material.dart';
import 'package:task_showroom/core/utils/app_color.dart';




class AppTheme {
  static ThemeData themeData = ThemeData(
    fontFamily: 'Popins',
    primaryColor: Colors.black,
    canvasColor: AppColors.secondaryColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.appColor,
    ),
    brightness: Brightness.light,
  );
}
