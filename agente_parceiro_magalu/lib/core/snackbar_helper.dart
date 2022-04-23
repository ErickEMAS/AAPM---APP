import 'package:flutter/material.dart';

class SnackBarHelper {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    BuildContext context, {
    required String message,
    Future<bool> Function()? callback,
  }) {
    final snackBar = SnackBar(
      content: WillPopScope(
        onWillPop: callback,
        child: Text(message),
      ),
    );
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
