import 'package:agente_parceiro_magalu/app/auth/presentation/pages/forgot_password.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/pages/sign_up_page.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/pages/login_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/account_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/calendar_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/dashboard_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/home_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/sellers_page.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DashboardPage(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginPage(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ForgotPasswordPage(),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SignUpPage(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomePage(),
        );
      case AppRoutes.sellers:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SellersPage(),
        );
      case AppRoutes.calendar:
        return MaterialPageRoute(
          
          settings: settings,
          builder: (_) => const CalendarPage(),
        );
      case AppRoutes.account:
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (_) => const AccountPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Nenhuma rota definida para ${settings.name}"),
            ),
          ),
        );
    }
  }
}
