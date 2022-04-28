import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
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
    return AppSafeArea(
      child: Scaffold(
        appBar: const AppBarGradient(
          title: "Carteira",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimens.margin),
            child: Column(
              children: [
                Text(
                  "Sellers",
                  style: AppTextStyles.bold(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AppBottomBar(role: widget.role),
      ),
    );
  }
}
