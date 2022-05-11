import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_field_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/shared/sheets/sheets_field.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SellerOverviewPage extends StatefulWidget {
  final String sellerId;

  const SellerOverviewPage({
    Key? key,
    required this.sellerId,
  }) : super(key: key);

  @override
  State<SellerOverviewPage> createState() => _SellerOverviewPageState();
}

class _SellerOverviewPageState extends State<SellerOverviewPage> {
  final SellerStore _store = serviceLocator<SellerStore>();

  @override
  void initState() {
    _store.setRole();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context)
          .during(_store.getSellerById(sellerId: widget.sellerId));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGradient(
        title: "Seller Overview",
      ),
      body: SingleChildScrollView(
        child: Observer(builder: (_) {
          return _store.sellerEditModel != null
              ? Column(
                  children: [
                    _sellerInfo(),
                    SizedBox(height: AppDimens.margin),
                    !_store.admin
                        ? _initVisita(_store.sellerEditModel!)
                        : Container(),
                  ],
                )
              : Container();
        }),
      ),
    );
  }

  _sellerInfo() {
    return Container(
      padding: EdgeInsets.all(AppDimens.margin),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Informações do seller",
                style: AppTextStyles.bold(),
              ),
              !_store.admin
                  ? ElevatedButton(
                      onPressed: () {
                        _store.navigateToEditSeller(context, widget.sellerId);
                      },
                      child: const Text("editar"),
                    )
                  : Container(),
            ],
          ),
          SizedBox(height: AppDimens.margin),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow(title: "Nome", content: _store.sellerEditModel!.nome),
              _infoRow(title: "CEP", content: _store.sellerEditModel!.cep),
              _infoRow(
                  title: "Endereço", content: _store.sellerEditModel!.endereco),
              _infoRow(
                  title: "Cidade", content: _store.sellerEditModel!.cidade),
              _infoRow(title: "UF", content: _store.sellerEditModel!.uf),
              _infoRow(
                  title: "Complemento",
                  content: _store.sellerEditModel!.complemento),
              _infoRow(title: "CNPJ", content: _store.sellerEditModel!.cnpj),
              _infoRow(title: "Email", content: _store.sellerEditModel!.email),
              _infoRow(
                  title: "Telefone", content: _store.sellerEditModel!.telefone),
              ..._store.sellerEditModel!.sellerFields!
                  .map<Widget>((SellerFieldModel sellerField) {
                return _infoColumn(
                    title: sellerField.name ?? "",
                    content: sellerField.value ?? "");
              }).toList(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _store.navigateToHistoricoChecklist(
                      context,
                      widget.sellerId,
                    );
                  },
                  child: Text("Ver histórico de visitas"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _initVisita(SellerModel sellerModel) {
    return Padding(
      padding: EdgeInsets.all(AppDimens.margin),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _store.navigateToChecklistVisita(context, sellerModel.id!);
          },
          child: const Text("Iniciar visita"),
        ),
      ),
    );
  }

  _infoRow({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "$title: ",
              style: AppTextStyles.bold(color: AppColors.primary, size: 16),
            ),
            Text(
              content,
              style: AppTextStyles.regular(size: 15),
            ),
          ],
        ),
        SizedBox(height: AppDimens.space),
      ],
    );
  }

  _infoColumn({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: AppTextStyles.bold(color: AppColors.primary, size: 16),
        ),
        Row(
          children: [
            Flexible(
              child: Text(
                content,
                style: AppTextStyles.regular(size: 15),
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimens.space),
      ],
    );
  }
}
