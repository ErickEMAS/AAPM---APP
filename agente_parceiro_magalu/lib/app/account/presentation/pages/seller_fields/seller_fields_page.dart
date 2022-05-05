import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';

class SellerFieldsPage extends StatefulWidget {
  const SellerFieldsPage({Key? key}) : super(key: key);

  @override
  State<SellerFieldsPage> createState() => _SellerFieldsPageState();
}

class _SellerFieldsPageState extends State<SellerFieldsPage> {

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        bottomNavigationBar: AppBottomBar(),
        appBar: const AppBarGradient(
          title: "seller_fields",
        ),
        body: const Text("seller_fields_page")
      ),
    );
  }
}
