import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../stores/questions_checklist_store.dart';

class QuestionsChecklistSearchFilterWidget extends StatefulWidget {
  const QuestionsChecklistSearchFilterWidget({Key? key}) : super(key: key);

  @override
  State<QuestionsChecklistSearchFilterWidget> createState() => _FAQSearchFilterWidgetState();
}

class _FAQSearchFilterWidgetState extends State<QuestionsChecklistSearchFilterWidget> {
final QuestionChecklistStore _store = serviceLocator<QuestionChecklistStore>();

  String? dropdownSelection;
  TextEditingController nomeSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          TextFormField(
            controller: nomeSearchController,
            decoration: const InputDecoration(
              labelText: "Pesquisa",
              hintText: "Pesquisar Questão",
            ),
            onChanged: (value) {
              _store.setStatus(value);
              _store.onQuestionsInit();
            },
          ),
          SizedBox(height: AppDimens.space),
        ],
      );
    });
  }
}
