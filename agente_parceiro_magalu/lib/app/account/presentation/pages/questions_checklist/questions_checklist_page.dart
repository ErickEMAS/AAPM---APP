import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/add_or_update_questions_checklist_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/questions_checklist_list_view.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/questions_checklist_store.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';

class QuestionsChecklistPage extends StatefulWidget {
  const QuestionsChecklistPage({Key? key}) : super(key: key);

  @override
  State<QuestionsChecklistPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<QuestionsChecklistPage> {
final QuestionChecklistStore _store = serviceLocator<QuestionChecklistStore>();

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
            title: "Questão",
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
                      child: const Text("Adicionar nova Questão"),
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
              return index == 0 ? const QuestionsChecklistListView() : AddOrUpdateQuestionsChecklistView(update: _store.update);
            },
          ),
          bottomNavigationBar: AppBottomBar(),
        );
      }),
    );
  }
}
