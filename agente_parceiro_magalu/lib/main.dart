import 'package:agente_parceiro_magalu/core/app_config.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/routes/app_router.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  AppConfig.setEnvironment(Environment.heroku);

  await setupLocators();

  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agente parceiro Magalu',
      theme: AppThemes.theme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRoutes.dashboard,
    );
  }
}
