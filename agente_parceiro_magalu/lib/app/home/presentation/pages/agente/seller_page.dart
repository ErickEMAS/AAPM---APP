import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/formatter_helper.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SellerPage extends StatefulWidget {
  final String role;
  const SellerPage({Key? key, required this.role}) : super(key: key);

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  final SellerStore _store = serviceLocator<SellerStore>();

  final PageController _pageController = PageController();

  bool isAddSeller = false;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _store.onSellerInit();
    _currentPage = 0;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  _nextPage() {
    _pageController
        .nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuad)
        .whenComplete(() => setState(() {}));
  }

  _previousPage() {
    _pageController
        .previousPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutQuad)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        appBar: AppBarGradient(
          leading: _currentPage == 1
              ? BackButton(
                  onPressed: () => _previousPage(),
                )
              : null,
          title: "Carteira",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _currentPage == 0
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _nextPage();
                    },
                    child: const Text("Adicionar novo Seller"),
                  ),
                ),
              )
            : null,
        body: PageView.builder(
          itemCount: 2,
          controller: _pageController,
          itemBuilder: (context, index) {
            return index == 0 ? _sellerListView() : _addSeller();
          },
        ),
        bottomNavigationBar: AppBottomBar(role: widget.role),
      ),
    );
  }

  _sellerListView() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Seller",
              style: AppTextStyles.bold(),
            ),
          ],
        ),
      ),
    );
  }

  _addSeller() {
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
                    print(_store.sellerModel.cnpj);
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
              ..._addSellerColumn(
                title: "Cidade",
                inputHint: "Digite a cidade",
                onChanged: (value) {
                  _store.sellerModel.cidade = value;
                },
              ),
              ..._addSellerColumn(
                title: "UF",
                inputHint: "Digite o UF",
                onChanged: (value) {
                  _store.sellerModel.uf = value;
                },
              ),
              ..._addSellerColumn(
                title: "CEP",
                inputHint: "Digite o CEP",
                onChanged: (value) {
                  _store.sellerModel.cep = value;
                },
              ),
              ..._addSellerColumn(
                title: "Endereço",
                inputHint: "Digite o endereço",
                onChanged: (value) {
                  _store.sellerModel.endereco = value;
                },
              ),
              ..._addSellerColumn(
                title: "Número",
                inputHint: "Digite o número",
                onChanged: (value) {
                  _store.sellerModel.numero = value;
                },
              ),
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
                      _previousPage();
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
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return [
      Text(
        title,
        style: AppTextStyles.regular(
          size: 14,
          color: AppColors.primary,
        ),
      ),
      TextFormField(
        onChanged: onChanged,
        validator: validator ?? InputValidatorHelper.validateCommonField,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(hintText: inputHint),
      ),
      SizedBox(height: AppDimens.space * 3)
    ];
  }
}
