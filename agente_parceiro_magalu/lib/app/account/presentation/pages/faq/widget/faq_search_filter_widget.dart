import 'package:agente_parceiro_magalu/app/account/presentation/stores/faq_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FAQSearchFilterWidget extends StatefulWidget {
  const FAQSearchFilterWidget({Key? key}) : super(key: key);

  @override
  State<FAQSearchFilterWidget> createState() => _FAQSearchFilterWidgetState();
}

class _FAQSearchFilterWidgetState extends State<FAQSearchFilterWidget> {
  final FAQStore _store = serviceLocator<FAQStore>();

  String? dropdownSelection;
  TextEditingController nomeSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          TextFormField(
            controller: nomeSearchController,
            decoration: const InputDecoration(
              labelText: "Pesquisa",
              hintText: "Pesquisar FAQ",
            ),
            onChanged: (value) {
              _store.setSearchFAQ(value);
              _store.onFAQInit();
            },
          ),
          SizedBox(height: AppDimens.space),
        ],
      );
    });
  }
}
