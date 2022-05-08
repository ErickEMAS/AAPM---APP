import 'package:agente_parceiro_magalu/app/account/presentation/pages/faq/add_or_update_faq_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/faq/faq_list_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/faq_store.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
final FAQStore _store = serviceLocator<FAQStore>();

  @override
  void initState() {
    super.initState();
    _store.reset();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onFAQInit());
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
            title: "FAQ",
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: _store.userRole == "ROLE_ADMIN" ? (_store.currentPage == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _store.update =  false;
                        _store.nextPage();
                      },
                      child: const Text("Adicionar nova FAQ"),
                    ),
                  ),
                )
              : null) : Container(),
          body: PageView.builder(
            clipBehavior: Clip.none,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            controller: _store.pageController,
            itemBuilder: (context, index) {
              return index == 0 ? const FAQListView() : AddOrUpdateFAQView(update: _store.update);
            },
          ),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
  }
}
