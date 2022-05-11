import 'package:agente_parceiro_magalu/app/sellers/data/models/alternatives_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/checklist_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/question_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/checklist_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/locators/service_locators.dart';

class ChecklistOverview extends StatefulWidget {
  final ChecklistModel checklistModel;
  const ChecklistOverview({Key? key, required this.checklistModel})
      : super(key: key);

  @override
  State<ChecklistOverview> createState() => _ChecklistOverviewState();
}

class _ChecklistOverviewState extends State<ChecklistOverview> {
  final ChecklistStore _checklistStore = serviceLocator<ChecklistStore>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGradient(
        title: "Checklist",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Visita feita: ${_checklistStore.formattDateTime(
                      widget.checklistModel.dataVisita ?? DateTime(2022),
                    )}",
                    style: AppTextStyles.bold(size: 14),
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space *2),
              Divider(),
              SizedBox(height: AppDimens.space *2),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.checklistModel.questions!.length,
                itemBuilder: (context, index) {
                  return _questionCard(
                    widget.checklistModel.questions![index],
                    index,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _questionCard(QuestionModel questionModel, int questionIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionModel.question!,
          style: AppTextStyles.bold(size: 14),
        ),
        SizedBox(height: AppDimens.space),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: questionModel.alternatives!.length,
          itemBuilder: (context, index) {
            return _checkboxTile(
              alternativeModel: questionModel.alternatives![index],
              indexAlternative: index,
              indexQuestion: questionIndex,
              questionModel: questionModel,
            );
          },
        ),
        SizedBox(height: AppDimens.space * 2),
      ],
    );
  }

  _checkboxTile({
    required AlternativeModel alternativeModel,
    required QuestionModel questionModel,
    required int indexAlternative,
    required int indexQuestion,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: CheckboxListTile(
            title: Text(
              alternativeModel.name ?? "",
              style: AppTextStyles.regular(size: 15),
            ),
            value: alternativeModel.checked,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (bool? value) {},
          ),
        ),
        alternativeModel.name == "Outro"
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
