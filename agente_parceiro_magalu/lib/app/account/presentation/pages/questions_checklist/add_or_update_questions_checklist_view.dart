import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../../core/locators/service_locators.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../shared/widgets/app_dropdown.dart';
import '../../../data/models/alternative_model.dart';
import '../../stores/questions_checklist_store.dart';

class AddOrUpdateQuestionsChecklistView extends StatefulWidget {
  final bool update;
  const AddOrUpdateQuestionsChecklistView({Key? key, required this.update})
      : super(key: key);

  @override
  State<AddOrUpdateQuestionsChecklistView> createState() => _AddOrUpdateQuestionsChecklistViewState();
}

class _AddOrUpdateQuestionsChecklistViewState extends State<AddOrUpdateQuestionsChecklistView> {
  final QuestionChecklistStore _store =
      serviceLocator<QuestionChecklistStore>();
  String? dropdownSelection;

  @override
  void dispose() {
    _store.resetmodels();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: Form(
          key: _store.formKey,
          child: questionForm(phoneWidth, context),
        ),
      ),
    );
  }

  questionForm(double phoneWidth, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.update ? "Editar Questão" : "Adicionar Questão",
          style: AppTextStyles.bold(),
        ),
        SizedBox(height: AppDimens.space * 4),
        questionAndAlternatives(phoneWidth),
        const Divider(),
        bollFields(),
        const Divider(),
        updateField(phoneWidth),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              bool formOk = _store.formKey.currentState!.validate();
              if (!formOk) return;

              bool ret = await LoadingOverlay.of(context).during(
                widget.update
                    ? _store.updateDynamicQuestion()
                    : _store.addDynamicQuestion(),
              );

              if (ret) {
                SnackBarHelper.snackBar(context,
                    message: widget.update
                        ? "Questão editar com sucesso!"
                        : "Questão cadastrado com sucesso!");
                await _store.onQuestionsInit();
                _store.previousPage();
                _store.formKey.currentState!.reset();
              } else {
                SnackBarHelper.snackBar(
                  context,
                  isError: true,
                  message: widget.update
                      ? "Ocorreu um erro ao editar!"
                      : "Ocorreu um erro ao cadastrar!",
                );
              }
            },
            child: Text(
              widget.update ? "Editar" : "Adicionar",
            ),
          ),
        ),
        SizedBox(height: AppDimens.margin * 2),
      ],
    );
  }

  Column updateField(double phoneWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Novo campo do Seller: ",
          style: AppTextStyles.bold(size: 14, color: AppColors.primary),
        ),
        ..._addFAQColumn(
          title: "Nome do campo",
          initialValue: widget.update
              ? _store.dynamicQuestionCheckListEditModel.question
              : "",
          inputHint: "Digite o nome do campo",
          onChanged: (value) {
            _store.dynamicQuestionCheckListEditModel.fieldUpdate.name =
                widget.update ? value : "";
            _store.dynamicQuestionCheckListModel.fieldUpdate.name = value;
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Tipo",
              style: AppTextStyles.bold(size: 12, color: AppColors.primary),
            ),
            AppDropdown(
              textHint:
                  _store.dynamicQuestionCheckListEditModel.fieldUpdate.type !=
                          null
                      ? (_store.dynamicQuestionCheckListEditModel.fieldUpdate
                                  .type ==
                              TypeField.TEXT
                          ? "Texto"
                          : "Número")
                      : "Tipo",
              width: phoneWidth,
              value: dropdownSelection,
              customItems: [
                DropdownMenuItem(
                  child: Text(
                    "Texto",
                    style: AppTextStyles.regular(
                      size: 16,
                      color: AppColors.black,
                    ),
                  ),
                  onTap: () {
                    _store.dynamicQuestionCheckListEditModel.fieldUpdate.type =
                        TypeField.TEXT;
                  },
                  value: "Texto",
                ),
                DropdownMenuItem(
                  child: Text(
                    "Número",
                    style: AppTextStyles.regular(
                      size: 16,
                      color: AppColors.black,
                    ),
                  ),
                  onTap: () {
                    _store.dynamicQuestionCheckListEditModel.fieldUpdate.type =
                        TypeField.INT;
                  },
                  value: "Número",
                ),
              ],
              onChange: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ],
    );
  }

  Column bollFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const Text('Resposta obrigatória'),
          value: _store.dynamicQuestionCheckListEditModel.answerRequired,
          onChanged: (bool value) {
            setState(
              () {
                _store.dynamicQuestionCheckListEditModel.answerRequired = value;
              },
            );
          },
        ),
        SwitchListTile(
          title: const Text('Multiplas Resposta'),
          value: _store.dynamicQuestionCheckListEditModel.multipleAlternative,
          onChanged: (bool value) {
            setState(
              () {
                _store.dynamicQuestionCheckListEditModel.multipleAlternative =
                    value;
              },
            );
          },
        ),
        SwitchListTile(
          title: const Text('Ativa'),
          value: _store.dynamicQuestionCheckListEditModel.active,
          onChanged: (bool value) {
            setState(
              () {
                _store.dynamicQuestionCheckListEditModel.active = value;
              },
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Column questionAndAlternatives(double phoneWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._addFAQColumn(
          title: "Questão",
          initialValue: widget.update
              ? _store.dynamicQuestionCheckListEditModel.question
              : "",
          inputHint: "Digite a questão",
          onChanged: (value) {
            _store.dynamicQuestionCheckListEditModel.question =
                widget.update ? value : "";
            _store.dynamicQuestionCheckListModel.question = value;
          },
        ),
        SizedBox(height: AppDimens.space * 2),
        Text(
          "Alternativas: ",
          style: AppTextStyles.bold(size: 14, color: AppColors.primary),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: phoneWidth * .60,
              child: TextFormField(
                controller: _store.newAlternativeController,
                // onChanged: (value) => {_store.newAlternative = value},
                decoration: InputDecoration(
                  hintText: "Nova Alternativa",
                  label: Text(
                    "Nova Alternativa",
                    style:
                        AppTextStyles.bold(size: 12, color: AppColors.primary),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _store.addNewAlternative();
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 16),
            Observer(
              builder: (_) {
                return Column(
                  children: _store.dynamicQuestionCheckListEditModel
                          .alternatives.isNotEmpty
                      ? _store.dynamicQuestionCheckListEditModel.alternatives
                          .map<Container>(
                          (AlternativeModel _alternativeModel) {
                            return Container(
                              width: phoneWidth * .8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _alternativeModel.name,
                                    style: AppTextStyles.bold(
                                        size: 14, color: AppColors.black),
                                  ),
                                  IconButton(
                                      onPressed: () => {
                                            setState(() {
                                              _store.removeAlternative(
                                                  alternativeModel:
                                                      _alternativeModel);
                                            })
                                          },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            );
                          },
                        ).toList()
                      : [Container()],
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  _addFAQColumn({
    required String title,
    required String inputHint,
    void Function(String)? onChanged,
    String? initialValue,
    double? width,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return [
      SizedBox(
        width: width ?? double.infinity,
        child: TextFormField(
          maxLines: null,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator ?? InputValidatorHelper.validateCommonField,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: inputHint,
            label: Text(
              title,
              style: AppTextStyles.bold(size: 12, color: AppColors.primary),
            ),
          ),
        ),
      ),
      SizedBox(height: AppDimens.space * 0.5),
    ];
  }
}
