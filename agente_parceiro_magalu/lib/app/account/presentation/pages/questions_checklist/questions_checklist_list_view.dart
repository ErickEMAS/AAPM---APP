import 'package:agente_parceiro_magalu/app/account/data/models/alternative_model.dart';
import 'package:agente_parceiro_magalu/app/account/data/models/dynamic_question_checkList_model.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/questions_checklist/widget/questions_checklist_search_filter_widget.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../shared/themes/app_text_styles.dart';
import '../../stores/questions_checklist_store.dart';

class QuestionsChecklistListView extends StatefulWidget {
  const QuestionsChecklistListView({Key? key}) : super(key: key);

  @override
  State<QuestionsChecklistListView> createState() => _FAQListViewState();
}

class _FAQListViewState extends State<QuestionsChecklistListView> {
  final QuestionChecklistStore _store =
      serviceLocator<QuestionChecklistStore>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LoadingOverlay.of(context).during(_store.fetchNextPage());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Observer(builder: (_) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        _store.setSearchClicked(!_store.searchClicked);
                      },
                      icon: Icon(
                          _store.searchClicked ? Icons.close : Icons.filter_list),
                    )
                  ],
                ),
                _store.searchClicked
                    ? const QuestionsChecklistSearchFilterWidget()
                    : const SizedBox(),
              ],
            );
          }),
        ),
        Observer(builder: (_) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _store.questionList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  margin: const EdgeInsets.only(bottom: 16, top: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: phoneWidth * .8,
                        child: _questionItem(
                          question: _store.questionList[index],
                        ),
                      ),
                      IconButton(
                        onPressed: () => {
                          _store.update = true,
                          _store.dynamicQuestionCheckListEditModel =
                              _store.questionList[index],
                          _store.nextPage(),
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
        SizedBox(height: AppDimens.margin * 3)
      ],
    );
  }

  Row _questionItem({required DynamicQuestionCheckListModel question}) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Questão: ",
                    style:
                        AppTextStyles.bold(size: 14, color: AppColors.primary),
                  ),
                  Text(
                    question.question,
                    style: AppTextStyles.bold(size: 14, color: AppColors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Questão Obrigatório: ",
                    style:
                        AppTextStyles.bold(size: 14, color: AppColors.primary),
                  ),
                  Text(
                    question.answerRequired ? "Sim" : "Não",
                    style: AppTextStyles.bold(size: 14, color: AppColors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Multipla escolha: ",
                    style:
                        AppTextStyles.bold(size: 14, color: AppColors.primary),
                  ),
                  Text(
                    question.multipleAlternative ? "Sim" : "Não",
                    style: AppTextStyles.bold(size: 14, color: AppColors.black),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ativa: ",
                    style:
                        AppTextStyles.bold(size: 14, color: AppColors.primary),
                  ),
                  Text(
                    question.active ? "Sim" : "Não",
                    style: AppTextStyles.bold(size: 14, color: AppColors.black),
                  ),
                ],
              ),
              Text(
                "Alternativas: ",
                style: AppTextStyles.bold(size: 14, color: AppColors.primary),
              ),
              Row(
                children: [
                  const SizedBox(width: 16),
                  Column(
                    children: question.alternatives.map<Text>(
                      (AlternativeModel alt) {
                        return Text(
                          alt.name,
                          style: AppTextStyles.bold(
                              size: 14, color: AppColors.black),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              Text(
                "Campo a ser atualizado: ",
                style: AppTextStyles.bold(size: 14, color: AppColors.primary),
              ),
              Row(
                children: [
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "nome: ",
                            style: AppTextStyles.bold(
                                size: 14, color: AppColors.primary),
                          ),
                          Text(
                            question.fieldUpdate.name,
                            style: AppTextStyles.bold(
                                size: 14, color: AppColors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "tipo: ",
                            style: AppTextStyles.bold(
                                size: 14, color: AppColors.primary),
                          ),
                          Text(
                            question.fieldUpdate.type == TypeField.TEXT
                                ? "Texto"
                                : "Número",
                            style: AppTextStyles.bold(
                                size: 14, color: AppColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
