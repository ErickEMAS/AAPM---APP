import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle regular({
    Color? color,
    double? size,
  }) =>
      GoogleFonts.mPlusRounded1c(
        color: color ?? AppColors.black,
        fontSize: size ?? 12,
        fontWeight: FontWeight.w500,
      );

  static TextStyle bold({
    Color? color,
    double? size,
  }) =>
      GoogleFonts.mPlusRounded1c(
        color: color ?? AppColors.black,
        fontSize: size ?? 19,
        fontWeight: FontWeight.w700,
      );
}
