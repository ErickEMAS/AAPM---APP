import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class SellersPage extends StatefulWidget {
  final String role;
  const SellersPage({Key? key, required this.role}) : super(key: key);

  @override
  State<SellersPage> createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AppBottomBar(role: widget.role),
        appBar: const AppBarGradient(
          title: "Carteira",
        ),
      ),
    );
  }
}
