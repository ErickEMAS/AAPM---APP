import 'package:agente_parceiro_magalu/shared/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.theme,
    );
  }
}
