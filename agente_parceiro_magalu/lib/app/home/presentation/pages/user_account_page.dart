import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class UserAccountPage extends StatefulWidget {
  final String role;
  const UserAccountPage({Key? key, required this.role}) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AppBottomBar(role: widget.role),
        appBar: const AppBarGradient(
          title: "Minha conta",
        ),
      ),
    );
  }
}
