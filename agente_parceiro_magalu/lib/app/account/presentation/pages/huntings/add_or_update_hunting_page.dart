import 'package:agente_parceiro_magalu/app/account/presentation/stores/hunting_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/loading_overlay.dart';
import '../../../../../core/snackbar_helper.dart';

class AddUpdateHuntingPage extends StatefulWidget {
  const AddUpdateHuntingPage({Key? key}) : super(key: key);

  @override
  State<AddUpdateHuntingPage> createState() => _AddUpdateHuntingPageState();
}

class _AddUpdateHuntingPageState extends State<AddUpdateHuntingPage> {
  final HuntingStore _store = serviceLocator<HuntingStore>();

  double phoneWidth = 0;
  final formKey = GlobalKey<FormState>();

  late SellerModel sellerModel;

  @override
  void dispose() {
    _store.resetModels();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    phoneWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: Form(
          key: _store.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _store.update ? "Editar Hunting" : "Adicionar Hunting",
                    style: AppTextStyles.bold(),
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space * 4),
              ..._addSellerColumn(
                title: "Nome",
                validator: (value) => _store.validateRequired(value),
                initialValue: _store.update
                    ? _store.huntingEditModel.nome
                    : _store.huntingModel.nome,
                inputHint: "Digite o nome",
                onChanged: (value) {
                  _store.update
                      ? _store.huntingEditModel.nome = value
                      : _store.huntingModel.nome = value;
                },
              ),
              ..._addSellerColumn(
                title: "Telefone",
                initialValue: _store.update
                    ? _store.huntingEditModel.telefone
                    : _store.huntingModel.telefone,
                inputHint: "Digite o telefone",
                onChanged: (value) {
                  _store.update
                      ? _store.huntingEditModel.telefone = value
                      : _store.huntingModel.telefone = value;
                },
              ),
              ..._addSellerColumn(
                title: "E-mail",
                initialValue: _store.update
                    ? _store.huntingEditModel.telefone
                    : _store.huntingModel.telefone,
                inputHint: "Digite o e-mail",
                onChanged: (value) {
                  _store.update
                      ? _store.huntingEditModel.email = value
                      : _store.huntingModel.email = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ..._addSellerColumn(
                    width: phoneWidth * 0.4,
                    title: "Cidade",
                    initialValue: _store.update
                        ? _store.huntingEditModel.cidade
                        : _store.huntingModel.cidade,
                    inputHint: "Digite a cidade",
                    onChanged: (value) {
                      _store.update
                          ? _store.huntingEditModel.cidade = value
                          : _store.huntingModel.cidade = value;
                    },
                  ),
                  ..._addSellerColumn(
                    width: phoneWidth * 0.2,
                    title: "UF",
                    initialValue: _store.update
                        ? _store.huntingEditModel.uf
                        : _store.huntingModel.uf,
                    inputHint: "Digite o UF",
                    onChanged: (value) {
                      _store.update
                          ? _store.huntingEditModel.uf = value
                          : _store.huntingModel.uf = value;
                    },
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space * 0.5),
              ..._addSellerColumn(
                title: "CEP",
                initialValue: _store.update
                    ? _store.huntingEditModel.cep
                    : _store.huntingModel.cep,
                inputHint: "Digite o CEP",
                onChanged: (value) {
                  _store.update
                      ? _store.huntingEditModel.cep = value
                      : _store.huntingModel.cep = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ..._addSellerColumn(
                    title: "Endereço",
                    initialValue: _store.update
                        ? _store.huntingEditModel.endereco
                        : _store.huntingModel.endereco,
                    width: phoneWidth * 0.4,
                    inputHint: "Digite o endereço",
                    onChanged: (value) {
                      _store.update
                          ? _store.huntingEditModel.endereco = value
                          : _store.huntingModel.endereco = value;
                    },
                  ),
                  ..._addSellerColumn(
                    title: "Número",
                    initialValue: _store.update
                        ? _store.huntingEditModel.numero
                        : _store.huntingModel.numero,
                    width: phoneWidth * 0.2,
                    inputHint: "Digite o número",
                    onChanged: (value) {
                      _store.update
                          ? _store.huntingEditModel.numero = value
                          : _store.huntingModel.numero = value;
                    },
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space * 0.5),
              ..._addSellerColumn(
                title: "Complemento",
                initialValue: _store.update
                    ? _store.huntingEditModel.complemento
                    : _store.huntingModel.complemento,
                inputHint: "Digite o complemento",
                onChanged: (value) {
                  _store.update
                      ? _store.huntingEditModel.complemento = value
                      : _store.huntingModel.complemento = value;
                },
              ),
              SizedBox(height: AppDimens.space * 3),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool formOk = _store.formKey.currentState == null
                        ? false
                        : _store.formKey.currentState!.validate();
                    if (!formOk) return;

                    bool ret = await LoadingOverlay.of(context).during(
                      _store.update
                          ? _store.updateHunting()
                          : _store.addHunting(),
                    );

                    if (ret) {
                      SnackBarHelper.snackBar(context,
                          message: _store.update
                              ? "Hunting editar com sucesso!"
                              : "Hunting cadastrado com sucesso!");
                      await _store.onHuntinInit();
                      _store.update = false;
                      _store.update
                          ? _store.navigateToHuntingOverview(context)
                          : null;
                      _store.previousPage();
                      _store.formKey.currentState!.reset();
                    } else {
                      SnackBarHelper.snackBar(
                        context,
                        isError: true,
                        message: _store.update
                            ? "Ocorreu um erro ao editar!"
                            : "Ocorreu um erro ao cadastrar!",
                      );
                    }
                  },
                  child: Text(_store.update ? "Editar" : "Adicionar"),
                ),
              ),
              SizedBox(height: AppDimens.margin * 3),
            ],
          ),
        ),
      ),
    );
  }

  _addSellerColumn({
    required String title,
    required String inputHint,
    String? initialValue,
    void Function(String)? onChanged,
    double? width,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return [
      SizedBox(
        width: width ?? double.infinity,
        child: TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator ?? null,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: inputHint,
            label: Text(
              title,
            ),
          ),
        ),
      ),
      SizedBox(height: AppDimens.space * 0.5)
    ];
  }

  _tagDialog() {
    return appDialog(
      context: context,
      title: Text(
        "Adicionar nova tag",
        style: AppTextStyles.bold(size: 16, color: AppColors.primary),
      ),
    );
  }
}
