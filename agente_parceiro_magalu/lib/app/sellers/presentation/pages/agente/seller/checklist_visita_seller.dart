import 'package:agente_parceiro_magalu/app/sellers/data/models/alternatives_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/question_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/checklist_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChecklistVisitaSeller extends StatefulWidget {
  String sellerId;

  ChecklistVisitaSeller({
    Key? key,
    required this.sellerId,
  }) : super(key: key);

  @override
  State<ChecklistVisitaSeller> createState() => _ChecklistVisitaSellerState();
}

class _ChecklistVisitaSellerState extends State<ChecklistVisitaSeller> {
  final ChecklistStore _checklistStore = serviceLocator<ChecklistStore>();

  List<QuestionsModel> isQuestionChecked = [];
  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context)
          .during(_checklistStore.startChecklist(widget.sellerId));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGradient(
        title: "Checklist Visita",
      ),
      body: Observer(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
            child: Column(
              children: [
                SizedBox(height: AppDimens.margin),
                _checklistStore.checklistModel!.questions != null
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            _checklistStore.checklistModel!.questions!.length,
                        itemBuilder: (context, index) {
                          return _questionCard(
                            _checklistStore.checklistModel!.questions![index],
                          );
                        },
                      )
                    : const SizedBox(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // if (isQuestionCheckedQuestionLenght <
                      //     _checklistStore.checklistModel!.questions!.length) {
                      //   SnackBarHelper.snackBar(
                      //     context,
                      //     isError: true,
                      //     message: "Você deve marcar todos os campos",
                      //   );
                      // } else {
                      _checklistStore.answerChecklist(isQuestionChecked);
                      // }
                    },
                    child: const Text("Enviar checklist"),
                  ),
                ),
                SizedBox(height: AppDimens.margin * 4),
              ],
            ),
          ),
        );
      }),
    );
  }

  _questionCard(QuestionsModel questionsModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionsModel.question!,
          style: AppTextStyles.bold(size: 14),
        ),
        SizedBox(height: AppDimens.space),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: questionsModel.alternatives!.length,
          itemBuilder: (context, index) {
            return _checkboxTile(
              alternativesModel: questionsModel.alternatives![index],
              questionsModel: questionsModel,
            );
          },
        ),
      ],
    );
  }

  _checkboxTile({
    required AlternativesModel alternativesModel,
    required QuestionsModel questionsModel,
  }) {
    bool checklistValue = isQuestionChecked
        .map((quest) => quest.answer)
        .contains(alternativesModel.title);

    return Column(
      children: [
        SizedBox(
          height: 40,
          child: CheckboxListTile(
              title: Text(
                alternativesModel.title ?? "",
                style: AppTextStyles.regular(size: 15),
              ),
              // dense: true,
              value: checklistValue,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                if (value! == true) {
                  QuestionsModel questionsModelMock = QuestionsModel();
                  questionsModelMock.answer = alternativesModel.title;
                  questionsModelMock.id = questionsModel.id;
                  questionsModelMock.fieldUpdateId =
                      questionsModel.fieldUpdateId;
                  questionsModelMock.active = true;

                  setState(() {
                    isQuestionChecked.add(questionsModelMock);
                  });
                } else {
                  setState(() {
                    isQuestionChecked.removeWhere(
                      (item) => item.answer == alternativesModel.title,
                    );
                  });
                }
              }),
        ),
        alternativesModel.title == "Outro"
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.77,
                child: TextFormField(
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(borderSide: BorderSide()),
                      hintText: "Qual outro?",
                      focusedBorder: OutlineInputBorder()),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
