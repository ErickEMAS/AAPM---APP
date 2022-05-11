import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../core/locators/service_locators.dart';
import '../../../../../shared/widgets/app_dropdown.dart';
import '../../stores/seller_fields_store.dart';

class AddOrUpdateSellerFieldslistView extends StatefulWidget {
  final bool update;
  const AddOrUpdateSellerFieldslistView({Key? key, required this.update})
      : super(key: key);

  @override
  State<AddOrUpdateSellerFieldslistView> createState() => _AddOrUpdateSellerFieldslistViewState();
}

class _AddOrUpdateSellerFieldslistViewState extends State<AddOrUpdateSellerFieldslistView> {
  final SellerFieldsStore _store = serviceLocator<SellerFieldsStore>();
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
                title: "Nome",
                initialValue:
                    widget.update ? _store.dynamicFieldEditModel.name : "",
                inputHint: "Digite o Nome do campo",
                onChanged: (value) {
                  _store.dynamicFieldEditModel.name =
                      widget.update ? value : "";
                  _store.dynamicFieldModel.name = value;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Tipo",
                    style:
                        AppTextStyles.bold(size: 12, color: AppColors.primary),
                  ),
                  AppDropdown(
                    textHint: _store.dynamicFieldModel.type != null
                        ? (_store.dynamicFieldModel.type == TypeField.TEXT
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
                          _store.dynamicFieldModel.type = TypeField.TEXT;
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
                          _store.dynamicFieldModel.type = TypeField.INT;
                        },
                        value: "Número",
                      ),
                    ],
                    onChange: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
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
                              ? "Campo editar com sucesso!"
                              : "Campo cadastrado com sucesso!");
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
