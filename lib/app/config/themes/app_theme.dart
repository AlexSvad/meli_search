import 'package:flutter/material.dart';

import '../colors/colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'ProximaNova',
      appBarTheme: const AppBarTheme(
        color: AppColors.primaryYellow,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primaryYellow,
        secondary: AppColors.secondaryBlue,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        },
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryBlue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryBlueVariant,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryBlue,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: AppColors.secondaryBlue,
        ),
        hintStyle: TextStyle(
          color: AppColors.secondaryBlue,
        ),
        errorStyle: TextStyle(
          color: AppColors.error,
        ),
      ),
    );
  }
}
