import 'package:agente_parceiro_magalu/app/sellers/data/models/alternatives_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/question_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/checklist_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
      body: Column(
        children: [
          _checklistStore.checklistModel!.questions != null
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
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
      ),
    );
  }

  _questionCard(QuestionsModel questionsModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          questionsModel.question!,
          style: AppTextStyles.regular(size: 14),
        ),
        SizedBox(height: AppDimens.space),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: questionsModel.alternatives!.length,
          itemBuilder: (context, index) {
            return _checkboxTile(questionsModel.alternatives![index]);
          },
        )
      ],
    );
  }

  _checkboxTile(AlternativesModel alternativesModel) {
    print(alternativesModel.tittle);
    return CheckboxListTile(
      title: Text(
        alternativesModel.tittle ?? "",
        style: AppTextStyles.bold(),
      ),
      value: true,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {},
    );
  }
}
