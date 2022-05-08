import 'package:agente_parceiro_magalu/app/account/data/models/faq_model.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/pages/faq/widget/faq_search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/faq_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/search_filter_widget.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../shared/themes/app_colors.dart';

class FAQListView extends StatefulWidget {
  const FAQListView({Key? key}) : super(key: key);

  @override
  State<FAQListView> createState() => _FAQListViewState();
}

class _FAQListViewState extends State<FAQListView> {
  final FAQStore _store = serviceLocator<FAQStore>();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LoadingOverlay.of(context).during(_store.fetchNextPage());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppDimens.margin),
              child: Observer(builder: (_) {
                return Column(
                  children: const [
                    FAQSearchFilterWidget(),
                  ],
                );
              }),
            ),
            Observer(builder: (_) {
              return _store.faqList.isNotEmpty
                  ? ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _store.faqList[index].open = !isExpanded;
                        });
                      },
                      children: _store.faqList
                          .map<ExpansionPanel>((FAQModel faqModel) {
                        return ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                faqModel.question,
                              ),
                            );
                          },
                          body: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ListTile(subtitle: Text(faqModel.answer)),
                                    SizedBox(height: AppDimens.margin)
                                  ],
                                ),
                              ),
                              _store.userRole == "ROLE_ADMIN"
                                  ? Container(
                                      child: GestureDetector(
                                        onTap: () => {
                                          _store.update = true,
                                          _store.faqEditModel = faqModel,
                                          _store.nextPage(),
                                        },
                                        child: Column(
                                          children: const [
                                            Icon(
                                              Icons.edit,
                                              size: 32,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              const SizedBox(width: 16)
                            ],
                          ),
                          isExpanded: faqModel.open,
                        );
                      }).toList(),
                    )
                  : const Text("Nenhum FAQ foi encontrado");
            }),
            SizedBox(height: AppDimens.margin * 3)
          ],
        ),
      ),
    );
  }
}
