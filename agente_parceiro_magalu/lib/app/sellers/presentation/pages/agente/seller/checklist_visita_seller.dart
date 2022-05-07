import 'package:agente_parceiro_magalu/app/sellers/data/models/alternatives_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/checklist_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/question_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/checklist_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
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
  // List<String> isChecked = [];
  List<ChecklistModel> isChecked = [];
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
        return Column(
          children: [
            _checklistStore.checklistModel!.questions!.isEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimens.margin),
                      itemCount:
                          _checklistStore.checklistModel!.questions!.length,
                      itemBuilder: (context, index) {
                        return _questionCard(
                          _checklistStore.checklistModel!.questions![index],
                        );
                      },
                    ),
                  )
                : SizedBox(),
          ],
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
        )
      ],
    );
  }

  _checkboxTile({
    required AlternativesModel alternativesModel,
    required QuestionsModel questionsModel,
  }) {
    bool checklistValue = isChecked.any(
      (check) => check.questions!
          .map((quest) => quest.answer)
          .contains(alternativesModel.title),
    );

    return Column(
      children: [
        CheckboxListTile(
            title: Text(
              alternativesModel.title ?? "",
              style: AppTextStyles.regular(size: 15),
            ),
            dense: true,
            value: checklistValue,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {
              if (value! == true) {
                QuestionsModel questionsModelMock = QuestionsModel();
                questionsModelMock.id = questionsModel.id;
                questionsModelMock.question = questionsModel.question;
                questionsModelMock.answer = alternativesModel.title;
                setState(() {
                  ChecklistModel checklistAdd = ChecklistModel(
                    id: _checklistStore.checklistModel!.id,
                    dataVisita: DateTime.now(),
                    questions: [questionsModelMock],
                  );
                  isChecked.add(checklistAdd);
                });
              } else {
                setState(() {
                  isChecked.removeWhere((check) {
                    bool test = check.questions!.any(
                      (question) => question.answer == alternativesModel.title,
                    );
                    return test;
                  });
                });
              }
            }),
        alternativesModel.title == "Outro" ||
                alternativesModel.title == "Outros" ||
                alternativesModel.title == "Outro:"
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
            : SizedBox()
      ],
    );
  }
}
