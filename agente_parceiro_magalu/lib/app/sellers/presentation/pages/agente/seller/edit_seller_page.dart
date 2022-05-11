import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/formatter_helper.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import '../../../../data/models/seller_field_model.dart';

class EditSellerPage extends StatefulWidget {
  final String sellerId;

  const EditSellerPage({
    Key? key,
    required this.sellerId,
  }) : super(key: key);

  @override
  State<EditSellerPage> createState() => _EditSellerPageState();
}

class _EditSellerPageState extends State<EditSellerPage> {
  final SellerStore _store = serviceLocator<SellerStore>();

  double phoneWidth = 0;
  final formKey = GlobalKey<FormState>();

  late SellerModel sellerModel;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context)
          .during(_store.getSellerById(sellerId: widget.sellerId));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    phoneWidth = MediaQuery.of(context).size.width;
    int i = -1;
    return Scaffold(
      appBar: const AppBarGradient(
        title: "Editar Seller",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Editar Seller",
                      style: AppTextStyles.bold(),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _tagDialog();
                      },
                      child: const Text("adicionar tag"),
                    )
                  ],
                ),
                SizedBox(height: AppDimens.space * 4),
                ..._addSellerColumn(
                    title: "CNPJ",
                    initialValue: _store.sellerEditModel!.cnpj,
                    inputHint: "Digite o CNPJ",
                    onChanged: (value) {
                      _store.sellerEditModel!.cnpj = value;
                    },
                    inputFormatters: [CpfCnpjInputMask(isCNPJ: true)]),
                ..._addSellerColumn(
                  title: "Nome",
                  initialValue: _store.sellerEditModel!.nome,
                  inputHint: "Digite o nome",
                  onChanged: (value) {
                    _store.sellerEditModel!.nome = value;
                  },
                ),
                ..._addSellerColumn(
                  title: "Helena Seller Code",
                  initialValue: _store.sellerEditModel!.helenaSellerCode,
                  inputHint: "Digite o helena seller code",
                  onChanged: (value) {
                    _store.sellerEditModel!.helenaSellerCode = value;
                  },
                ),
                ..._addSellerColumn(
                  title: "Telefone",
                  initialValue: _store.sellerEditModel!.telefone,
                  inputHint: "Digite o telefone",
                  onChanged: (value) {
                    _store.sellerEditModel!.telefone = value;
                  },
                ),
                ..._addSellerColumn(
                  title: "E-mail",
                  initialValue: _store.sellerEditModel!.telefone,
                  inputHint: "Digite o e-mail",
                  onChanged: (value) {
                    _store.sellerEditModel!.email = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ..._addSellerColumn(
                      width: phoneWidth * 0.4,
                      title: "Cidade",
                      initialValue: _store.sellerEditModel!.cidade,
                      inputHint: "Digite a cidade",
                      onChanged: (value) {
                        _store.sellerEditModel!.cidade = value;
                      },
                    ),
                    ..._addSellerColumn(
                      width: phoneWidth * 0.2,
                      title: "UF",
                      initialValue: _store.sellerEditModel!.uf,
                      inputHint: "Digite o UF",
                      onChanged: (value) {
                        _store.sellerEditModel!.uf = value;
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.space * 0.5),
                ..._addSellerColumn(
                  title: "CEP",
                  initialValue: _store.sellerEditModel!.cep,
                  inputHint: "Digite o CEP",
                  onChanged: (value) {
                    _store.sellerEditModel!.cep = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ..._addSellerColumn(
                      title: "Endereço",
                      initialValue: _store.sellerEditModel!.endereco,
                      width: phoneWidth * 0.4,
                      inputHint: "Digite o endereço",
                      onChanged: (value) {
                        _store.sellerEditModel!.endereco = value;
                      },
                    ),
                    ..._addSellerColumn(
                      title: "Número",
                      initialValue: _store.sellerEditModel!.numero,
                      width: phoneWidth * 0.2,
                      inputHint: "Digite o número",
                      onChanged: (value) {
                        _store.sellerEditModel!.numero = value;
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.space * 0.5),
                ..._addSellerColumn(
                  title: "Complemento",
                  initialValue: _store.sellerEditModel!.complemento,
                  inputHint: "Digite o complemento",
                  onChanged: (value) {
                    _store.sellerEditModel!.complemento = value;
                  },
                ),
                ..._store.sellerEditModel!.sellerFields!
                    .map<Widget>((SellerFieldModel sellerField) {
                  i++;
                  return Column(
                    children: [
                      SizedBox(height: AppDimens.space * 3),
                      ..._addSellerColumn(
                        title: sellerField.name ?? "",
                        initialValue: sellerField.value ?? "",
                        inputHint: sellerField.name ?? "",
                        onChanged: (value) {
                          _store.sellerEditModel!.sellerFields![i].value =
                              value;
                        },
                      )
                    ],
                  );
                }),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      _store.updateSeller();
                      _store.navigateback(context);
                    },
                    child: const Text("Editar"),
                  ),
                ),
                SizedBox(height: AppDimens.margin * 3),
              ],
            ),
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
          validator: validator ?? InputValidatorHelper.validateCommonField,
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
      title: GestureDetector(
        onTap: () => {},
        child: Text(
          "Adicionar nova tag",
          style: AppTextStyles.bold(size: 16, color: AppColors.primary),
        ),
      ),
    );
  }
}
