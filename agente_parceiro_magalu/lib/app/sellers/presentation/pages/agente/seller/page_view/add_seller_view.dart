import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/formatter_helper.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../core/locators/service_locators.dart';

class AddSellerView extends StatelessWidget {
  AddSellerView({Key? key}) : super(key: key);

  final SellerStore _store = serviceLocator<SellerStore>();

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
                "Adicionar Seller",
                style: AppTextStyles.bold(),
              ),
              SizedBox(height: AppDimens.space * 4),
              ..._addSellerColumn(
                  title: "CNPJ",
                  inputHint: "Digite o CNPJ",
                  onChanged: (value) {
                    _store.sellerModel.cnpj = value;
                  },
                  inputFormatters: [CpfCnpjInputMask(isCNPJ: true)]),
              ..._addSellerColumn(
                title: "Nome",
                inputHint: "Digite o nome",
                onChanged: (value) {
                  _store.sellerModel.nome = value;
                },
              ),
              ..._addSellerColumn(
                title: "Helena Seller Code",
                inputHint: "Digite o helena seller code",
                onChanged: (value) {
                  _store.sellerModel.helenaSellerCode = value;
                },
              ),
              ..._addSellerColumn(
                title: "Telefone",
                inputHint: "Digite o telefone",
                onChanged: (value) {
                  _store.sellerModel.telefone = value;
                },
              ),
              ..._addSellerColumn(
                title: "E-mail",
                inputHint: "Digite o e-mail",
                onChanged: (value) {
                  _store.sellerModel.email = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ..._addSellerColumn(
                    width: phoneWidth * 0.4,
                    title: "Cidade",
                    inputHint: "Digite a cidade",
                    onChanged: (value) {
                      _store.sellerModel.cidade = value;
                    },
                  ),
                  ..._addSellerColumn(
                    width: phoneWidth * 0.2,
                    title: "UF",
                    inputHint: "Digite o UF",
                    onChanged: (value) {
                      _store.sellerModel.uf = value;
                    },
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space * 0.5),
              ..._addSellerColumn(
                title: "CEP",
                inputHint: "Digite o CEP",
                onChanged: (value) {
                  _store.sellerModel.cep = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ..._addSellerColumn(
                    title: "Endereço",
                    width: phoneWidth * 0.4,
                    inputHint: "Digite o endereço",
                    onChanged: (value) {
                      _store.sellerModel.endereco = value;
                    },
                  ),
                  ..._addSellerColumn(
                    title: "Número",
                    width: phoneWidth * 0.2,
                    inputHint: "Digite o número",
                    onChanged: (value) {
                      _store.sellerModel.numero = value;
                    },
                  ),
                ],
              ),
              SizedBox(height: AppDimens.space * 0.5),
              ..._addSellerColumn(
                title: "Complemento",
                inputHint: "Digite o complemento",
                onChanged: (value) {
                  _store.sellerModel.complemento = value;
                },
              ),
              ..._addSellerColumn(
                title: "Cadastro",
                inputHint: "Digite o cadastro",
                onChanged: (value) {
                  _store.sellerModel.cadastro = value;
                },
              ),
              ..._addSellerColumn(
                title: "Data de pedido",
                inputHint: "Digite a data de pedido",
                onChanged: (value) {
                  _store.sellerModel.dataPedidoTeste = value;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool formOk = _store.formKey.currentState!.validate();
                    if (!formOk) return;

                    bool ret = await LoadingOverlay.of(context).during(
                      _store.addSeller(),
                    );

                    if (ret) {
                      SnackBarHelper.snackBar(context,
                          message: "Seller cadastrado com sucesso!");
                      await _store.onSellerInit();
                      _store.previousPage();
                      _store.formKey.currentState!.reset();
                    } else {
                      SnackBarHelper.snackBar(
                        context,
                        isError: true,
                        message: "Ocorreu um erro ao cadastrar!",
                      );
                    }
                  },
                  child: const Text("Adicionar"),
                ),
              ),
              SizedBox(height: AppDimens.margin * 2),
            ],
          ),
        ),
      ),
    );
  }

  _addSellerColumn({
    required String title,
    required String inputHint,
    void Function(String)? onChanged,
    double? width,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return [
      SizedBox(
        width: width ?? double.infinity,
        child: TextFormField(
          onChanged: onChanged,
          validator: validator ?? InputValidatorHelper.validateCommonField,
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
