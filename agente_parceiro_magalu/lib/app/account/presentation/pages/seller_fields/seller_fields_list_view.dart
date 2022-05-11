import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../shared/themes/app_text_styles.dart';
import '../../stores/seller_fields_store.dart';

class SellerFieldsListView extends StatefulWidget {
  const SellerFieldsListView({Key? key}) : super(key: key);

  @override
  State<SellerFieldsListView> createState() => _FAQListViewState();
}

class _FAQListViewState extends State<SellerFieldsListView> {
  final SellerFieldsStore _store = serviceLocator<SellerFieldsStore>();

  final ScrollController _scrollController = ScrollController();

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Observer(builder: (_) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _store.dynamicFieldModelList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.only(bottom: 16, top: 16),
                  margin: const EdgeInsets.only(bottom: 16, top: 16),
                  child: Row(
                    children: [
                      SizedBox(width: AppDimens.space * 2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "nome: ",
                                  style: AppTextStyles.bold(
                                      size: 14, color: AppColors.primary),
                                ),
                                Text(
                                  _store.dynamicFieldModelList[index].name,
                                  style: AppTextStyles.bold(
                                      size: 14, color: AppColors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "tipo: ",
                                  style: AppTextStyles.bold(
                                      size: 14, color: AppColors.primary),
                                ),
                                Text(
                                  _store.dynamicFieldModelList[index].type ==
                                          TypeField.TEXT
                                      ? "Texto"
                                      : "Número",
                                  style: AppTextStyles.bold(
                                      size: 14, color: AppColors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }),
        SizedBox(height: AppDimens.margin * 3)
      ],
    );
  }
}
