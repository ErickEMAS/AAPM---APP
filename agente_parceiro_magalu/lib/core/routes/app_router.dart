import 'package:agente_parceiro_magalu/app/account/presentation/pages/add_admin/add_admin_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/add_agente/add_agente_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/change_email/change_email_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/change_password/change_password_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/confirm_email/confirm_email_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/my_account/adm/admin_account_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/my_account/agente/user_account_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/questions_checklist_page.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/seller_fields/seller_fields_page.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/pages/forgot_password.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/pages/sign_up_page.dart';
import 'package:agente_parceiro_magalu/app/auth/presentation/pages/login_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/agente/agente_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/agente/calendar_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/dashboard_page.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/home_page.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/edit_seller_page.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/seller_overview_page.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/seller_page.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../app/account/presentation/pages/user_detail/user_detail_page.dart';

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
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const HomePage(),
        );
      case AppRoutes.agent:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const AgentPage(),
        );
      case AppRoutes.sellers:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const SellerPage(),
        );
      case AppRoutes.sellerOverview:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SellerOverviewPage(
            sellerId: settings.arguments.toString(),
          ),
        );
      case AppRoutes.editSeller:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => EditSellerPage(
            sellerId: settings.arguments.toString(),
          ),
        );
      case AppRoutes.calendar:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const CalendarPage(),
        );
      case AppRoutes.userAccount:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const UserAccountPage(),
        );
      case AppRoutes.adminAccount:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const AdminAccountPage(),
        );
      case AppRoutes.confirmEmail:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const ConfirmEmailPage(),
        );
      case AppRoutes.userDetail:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const UserDetailPage(),
        );
      case AppRoutes.changepassword:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const ChangePasswordPage(),
        );
      case AppRoutes.changeEmail:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const ChangeEmailPage(),
        );
      case AppRoutes.addagente:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const AddAgentePage(),
        );
      case AppRoutes.addAdmin:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const AddAdminPage(),
        );
      case AppRoutes.sellerFields:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const SellerFieldsPage(),
        );
      case AppRoutes.questionsChecklist:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, __, ___) => const QuestionsChecklistPage(),
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
