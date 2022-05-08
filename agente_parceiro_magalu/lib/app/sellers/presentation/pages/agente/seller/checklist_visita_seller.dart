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
import 'package:agente_parceiro_magalu/shared/widgets/app_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChecklistVisitaSeller extends StatefulWidget {
  final String sellerId;

  const ChecklistVisitaSeller({
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
                            index,
                          );
                        },
                      )
                    : const SizedBox(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool ret = await LoadingOverlay.of(context).during(
                        _checklistStore.answerChecklist(),
                      );

                      if (ret) {
                        Navigator.pop(context);
                        SnackBarHelper.snackBar(
                          context,
                          message: "Checklist salva com sucesso!",
                        );
                      } else {
                        SnackBarHelper.snackBar(
                          context,
                          isError: true,
                          message: "Falha ao salvar o checklist!",
                        );
                      }
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
            onChanged: (bool? value) {
              _checklistStore.checklistModel!.questions![indexQuestion]
                      .alternatives![indexAlternative].checked =
                  !_checklistStore.checklistModel!.questions![indexQuestion]
                      .alternatives![indexAlternative].checked;
              setState(() {});
            },
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
