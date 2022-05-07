import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';

class QuestionsChecklistPage extends StatefulWidget {
  const QuestionsChecklistPage({Key? key}) : super(key: key);

  @override
  State<QuestionsChecklistPage> createState() => _QuestionsChecklistPageState();
}

class _QuestionsChecklistPageState extends State<QuestionsChecklistPage> {

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        bottomNavigationBar: AppBottomBar(),
        appBar: const AppBarGradient(
          title: "questions_checklist_page",
        ),
        body: const Text("questions_checklist_page")
      ),
    );
  }
}
