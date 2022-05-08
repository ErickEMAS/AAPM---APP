import 'package:agente_parceiro_magalu/app/account/presentation/stores/faq_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../core/locators/service_locators.dart';

class AddOrUpdateFAQView extends StatefulWidget {
  bool update;
  AddOrUpdateFAQView({Key? key, required this.update}) : super(key: key);

  @override
  State<AddOrUpdateFAQView> createState() => _AddFAQViewState();
}

class _AddFAQViewState extends State<AddOrUpdateFAQView> {
  final FAQStore _store = serviceLocator<FAQStore>();
  String? dropdownSelection;

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: Form(
          key: _store.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.update ? "Editar Campo" : "Adicionar Campo",
                style: AppTextStyles.bold(),
              ),
              SizedBox(height: AppDimens.space * 4),
              ..._addFAQColumn(
                title: "Questão",
                initialValue: widget.update ? _store.faqEditModel.question : "",
                inputHint: "Digite a questão",
                onChanged: (value) {
                  _store.faqEditModel.question = widget.update ? value : "";
                  _store.faqModel.question = value;
                },
              ),
              ..._addFAQColumn(
                title: "Resposta",
                initialValue: widget.update ? _store.faqEditModel.answer : "",
                inputHint: "Digite a resposta",
                onChanged: (value) {
                  _store.faqEditModel.answer = widget.update ? value : "";
                  _store.faqModel.answer = value;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool formOk = _store.formKey.currentState!.validate();
                    if (!formOk) return;

                    bool ret = await LoadingOverlay.of(context).during(
                      widget.update ? _store.updateFAQ() : _store.addFAQ(),
                    );

                    if (ret) {
                      SnackBarHelper.snackBar(context,
                          message: widget.update
                              ? "Campo editar com sucesso!"
                              : "Campo cadastrado com sucesso!");
                      await _store.onFAQInit();
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
          ),
        ),
      ),
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
