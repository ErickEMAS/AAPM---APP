import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';

class AdminAccountPage extends StatefulWidget {
  final String role;
  const AdminAccountPage({Key? key, required this.role}) : super(key: key);

  @override
  State<AdminAccountPage> createState() => _AdminAccountPageState();
}

class _AdminAccountPageState extends State<AdminAccountPage> {
  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        bottomNavigationBar: AppBottomBar(role: widget.role),
        appBar: const AppBarGradient(
          title: "Minha conta",
        ),
      ),
    );
  }
}
