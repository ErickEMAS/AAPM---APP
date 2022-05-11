import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {}

class AppThemes {
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightGrey,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          AppColors.primary,
        ), //button color
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.white),
        textStyle: MaterialStateProperty.all<TextStyle>(
          AppTextStyles.bold(size: 18),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.primary),
        textStyle: MaterialStateProperty.all<TextStyle>(
          AppTextStyles.bold(size: 18),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: AppColors.primary,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: AppTextStyles.bold(
        size: 16,
        color: AppColors.primary,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
        ),
      ),
    ),
  );
}
