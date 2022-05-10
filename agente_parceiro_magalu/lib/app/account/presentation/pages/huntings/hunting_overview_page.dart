import 'package:agente_parceiro_magalu/app/account/presentation/stores/hunting_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HuntingOverviewPage extends StatefulWidget {
  const HuntingOverviewPage({Key? key}) : super(key: key);

  @override
  State<HuntingOverviewPage> createState() => _HuntingOverviewPageState();
}

class _HuntingOverviewPageState extends State<HuntingOverviewPage> {
  final HuntingStore _store = serviceLocator<HuntingStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGradient(
        title: "Hunting Overview",
      ),
      body: Observer(builder: (_) {
        return _store.huntingEditModel != null
            ? Column(
                children: [
                  _huntingInfo(),
                ],
              )
            : Container();
      }),
    );
  }

  _huntingInfo() {
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
                "Informações do hunting",
                style: AppTextStyles.bold(),
              ),
              ElevatedButton(
                onPressed: () {
                  _store.update = true;
                  _store.nextPage();
                  _store.navigateback(context);
                },
                child: const Text("editar"),
              ),
            ],
          ),
          SizedBox(height: AppDimens.margin),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoRow(title: "Nome", content: _store.huntingEditModel.nome!),
              _infoRow(title: "CEP", content: _store.huntingEditModel.cep!),
              _infoRow(
                  title: "Endereço", content: _store.huntingEditModel.endereco!),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoRow(
                        title: "Cidade",
                        content: _store.huntingEditModel.cidade!),
                    _infoRow(title: "UF", content: _store.huntingEditModel.uf!),
                  ],
                ),
              ),
              _infoRow(
                  title: "Complemento",
                  content: _store.huntingEditModel.complemento!),
              _infoRow(title: "Email", content: _store.huntingEditModel.email!),
              _infoRow(
                  title: "Telefone", content: _store.huntingEditModel.telefone!),
            ],
          ),
        ],
      ),
    );
  }

  _infoRow({required String title, required String content}) {
    return Column(
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
}
