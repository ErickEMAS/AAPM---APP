import 'package:agente_parceiro_magalu/app/account/presentation/pages/seller_fields/add_or_update_seller_fields_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/seller_fields/seller_fields_list_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/seller_fields_store.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';

class SellerFieldsPage extends StatefulWidget {
  const SellerFieldsPage({Key? key}) : super(key: key);

  @override
  State<SellerFieldsPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<SellerFieldsPage> {
final SellerFieldsStore _store = serviceLocator<SellerFieldsStore>();

  @override
  void initState() {
    super.initState();
    _store.reset();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onQuestionsInit());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Observer(builder: (_) {
        return Scaffold(
          appBar: AppBarGradient(
            leading: _store.currentPage == 1
                ? BackButton(
                    onPressed: () => _store.previousPage(),
                  )
                : null,
            title: "Campos do Seller",
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _store.currentPage == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _store.nextPage();
                      },
                      child: const Text("Adicionar novo campo"),
                    ),
                  ),
                )
              : null,
          body: PageView.builder(
            clipBehavior: Clip.none,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            controller: _store.pageController,
            itemBuilder: (context, index) {
              return index == 0 ? const SellerFieldsListView() : AddOrUpdateSellerFieldslistView(update: _store.update);
            },
          ),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
  }
}
