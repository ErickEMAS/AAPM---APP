import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/uf_builder.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/formatter_helper.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../../core/locators/service_locators.dart';

class AddSellerView extends StatefulWidget {
  AddSellerView({Key? key}) : super(key: key);

  @override
  State<AddSellerView> createState() => _AddSellerViewState();
}

class _AddSellerViewState extends State<AddSellerView> {
  final SellerStore _store = serviceLocator<SellerStore>();
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
                  keyboardType: TextInputType.number,
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  GeneralInputMask(formatterString: "(##) ####-####")
                ],
              ),
              ..._addSellerColumn(
                title: "E-mail",
                inputHint: "Digite o e-mail",
                keyboardType: TextInputType.emailAddress,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "UF",
                        style: AppTextStyles.bold(
                            size: 12, color: AppColors.primary),
                      ),
                      AppDropdown(
                        textHint: "UF",
                        width: phoneWidth * 0.4,
                        value: dropdownSelection,
                        customItems: UFbuilder.uf().map((uf) {
                          return DropdownMenuItem(
                            child: Text(
                              uf.toUpperCase(),
                              style: AppTextStyles.regular(
                                size: 16,
                                color: AppColors.black,
                              ),
                            ),
                            onTap: () {
                              _store.sellerModel.uf = uf;
                            },
                            value: uf,
                          );
                        }).toList(),
                        onChange: (value) {
                          print(dropdownSelection);
                          setState(() {
                            dropdownSelection = value;
                          });
                        },
                      ),
                    ],
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  GeneralInputMask(formatterString: "#####-###")
                ],
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
                    keyboardType: TextInputType.number,
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
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return [
      SizedBox(
        width: width ?? double.infinity,
        child: TextFormField(
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
