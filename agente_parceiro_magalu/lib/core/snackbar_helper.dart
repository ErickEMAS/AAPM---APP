import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    BuildContext context, {
    required String message,
    bool isError = false,
    Future<bool> Function()? callback,
  }) {
    final snackBar = SnackBar(
      backgroundColor: isError ? AppColors.vermelho : AppColors.primary,
      content: WillPopScope(
        onWillPop: callback,
        child: Text(message),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
