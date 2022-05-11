import 'package:agente_parceiro_magalu/app/account/presentation/pages/carteiras_without_Owner/carteiras_with_owner_list_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/carteiras_without_Owner/carteiras_overwith_owner_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/add_or_update_questions_checklist_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/questions_checklist_list_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/carteiras_without_owner_store.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';

class CarteirasWithOwnerPage extends StatefulWidget {
  const CarteirasWithOwnerPage({Key? key}) : super(key: key);

  @override
  State<CarteirasWithOwnerPage> createState() => _CarteirasWithOwnerPageState();
}

class _CarteirasWithOwnerPageState extends State<CarteirasWithOwnerPage> {
final CarteirasWithOwnerStore _store = serviceLocator<CarteirasWithOwnerStore>();

  @override
  void initState() {
    super.initState();
    _store.reset();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onQuestionsInit());
    });
  }

  @override
  void dispose() {
    _store.reset();
    super.dispose();
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
            title: "Carteiras Sem Agente",
          ),
          
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _store.currentPage == 1
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _store.navigateToAgentListForCarteiraView(context);
                        // _store.update =  false;
                        // _store.nextPage();
                      },
                      child: const Text("Tranferir Seller"),
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
              return index == 0 ? const CarteirasWithOwnerListView() : const CarteirasOverwithwithOwnerView();
            },
          ),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
  }
}
