import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String role;
  const HomePage({Key? key, required this.role}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        appBar: const AppBarGradient(
          automaticallyImplyLeading: false,
          title: "home page",
        ),
        bottomNavigationBar: AppBottomBar(role: widget.role),
      ),
    );
  }
}
