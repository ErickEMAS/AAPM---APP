import 'dart:convert';

import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/add_seller_view.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/seller_list_view.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/shared/sheets/sheets_field.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/api/google_api.dart';
import 'package:agente_parceiro_magalu/core/api/sheets/seller_sheets_api.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final SellerStore _store = serviceLocator<SellerStore>();

  PageController pageController = PageController();

  int currentPage = 0;

  _nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    _store.sellerList.clear();
    setState(() {
      currentPage = 1;
    });
    _store.reset();
  }

  _previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    LoadingOverlay.of(context).during(_store.onSellerInit());
    setState(() {
      currentPage = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onSellerInit());
    });
  }

  @override
  void dispose() {
    _store.sellerList.clear();
    _store.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Observer(builder: (_) {
        return Scaffold(
          appBar: AppBarGradient(
            leading: currentPage == 1
                ? BackButton(
                    onPressed: () => _previousPage(),
                  )
                : null,
            title: "Carteira",
            actions: [
              _exportAllSellersFromList(),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: currentPage == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _nextPage();
                      },
                      child: const Text("Adicionar novo Seller"),
                    ),
                  ),
                )
              : null,
          body: PageView.builder(
            clipBehavior: Clip.none,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            itemBuilder: (context, index) {
              return index == 0
                  ? const SellerListView()
                  : AddSellerView(
                      previousPage: _previousPage,
                    );
            },
          ),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
  }

  _exportAllSellersFromList() {
    return ElevatedButton(
      onPressed: () async {
        // List<SellerModel>? seller = await _store.getAllSellers();

        // await SellerSheetsApi.init();

        // if (seller != null) {
        //   final sellerDecode = SheetsFieldModel.fromJsonSellerModelList(
        //       jsonDecode(jsonEncode(seller)));

        //   final jsonList =
        //       sellerDecode.map((seller) => seller.toJson()).toList();

        //   SellerSheetsApi.insertList(jsonList);
        // }

        GoogleApi.signIn();
      },
      style: ElevatedButton.styleFrom(
        primary: AppColors.white,
      ),
      child: Text(
        "exportar",
        style: AppTextStyles.bold(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
