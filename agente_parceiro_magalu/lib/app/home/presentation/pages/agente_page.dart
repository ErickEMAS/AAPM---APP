import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:flutter/material.dart';

class AgentPage extends StatefulWidget {
  final String role;
  const AgentPage({Key? key, required this.role}) : super(key: key);

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: AppBottomBar(role: widget.role),
        appBar: const AppBarGradient(
          title: "agentes page",
        ),
      ),
    );
  }
}
