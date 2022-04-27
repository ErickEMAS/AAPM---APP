import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppSafeArea extends StatelessWidget {
  final Widget child;

  const AppSafeArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}
