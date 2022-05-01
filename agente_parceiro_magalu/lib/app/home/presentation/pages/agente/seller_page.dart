import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();

    _store.onSellerInit();
  }

  _nextPage() {
    _pageController
        .nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn)
        .whenComplete(() => setState(() {}));
  }

  _previousPage() {
    _pageController
        .previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.easeIn)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        appBar: const AppBarGradient(
          title: "Carteira",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                isAddSeller = _pageController.page == 1;
                isAddSeller ? _previousPage() : _nextPage();
              },
              child: isAddSeller
                  ? const Text("Adicionar Seller")
                  : const Text("Lista de Sellers"),
            ),
          ),
        ),
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
            ),
            ..._addSellerColumn(
              title: "Nome",
              inputHint: "Digite o nome",
            ),
            ..._addSellerColumn(
              title: "Helena Seller Code",
              inputHint: "Digite o helena seller code",
            ),
            ..._addSellerColumn(
              title: "Telefone",
              inputHint: "Digite o telefone",
            ),
            ..._addSellerColumn(
              title: "E-mail",
              inputHint: "Digite o e-mail",
            ),
            ..._addSellerColumn(
              title: "Cidade",
              inputHint: "Digite a cidade",
            ),
            ..._addSellerColumn(
              title: "UF",
              inputHint: "Digite o UF",
            ),
            ..._addSellerColumn(
              title: "CEP",
              inputHint: "Digite o CEP",
            ),
            ..._addSellerColumn(
              title: "Endereço",
              inputHint: "Digite o endereço",
            ),
            ..._addSellerColumn(
              title: "Número",
              inputHint: "Digite o número",
            ),
            ..._addSellerColumn(
              title: "Complemento",
              inputHint: "Digite o complemento",
            ),
            ..._addSellerColumn(
              title: "Cadastro",
              inputHint: "Digite o cadastro",
            ),
            ..._addSellerColumn(
              title: "Data de pedido",
              inputHint: "Digite a data de pedido",
            ),
            SizedBox(height: AppDimens.margin * 2)
          ],
        ),
      ),
    );
  }

  _addSellerColumn({
    required String title,
    required String inputHint,
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
        decoration: InputDecoration(hintText: inputHint),
      ),
      SizedBox(height: AppDimens.space * 3)
    ];
  }
}
