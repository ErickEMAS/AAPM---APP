import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle robotoRegular({
    Color? color,
    double? size,
  }) =>
      GoogleFonts.roboto(
        color: color ?? AppColors.black,
        fontSize: size ?? 12,
        fontWeight: FontWeight.w400,
      );

  static TextStyle robotoBold({
    Color? color,
    double? size,
  }) =>
      GoogleFonts.roboto(
        color: color ?? AppColors.black,
        fontSize: size ?? 12,
        fontWeight: FontWeight.w700,
      );
}
