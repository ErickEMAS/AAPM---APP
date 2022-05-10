import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../shared/themes/app_text_styles.dart';
import '../../stores/carteiras_without_owner_store.dart';

class CarteirasWithOwnerListView extends StatefulWidget {
  const CarteirasWithOwnerListView({Key? key}) : super(key: key);

  @override
  State<CarteirasWithOwnerListView> createState() =>
      _CarteirasWithOwnerViewState();
}

class _CarteirasWithOwnerViewState extends State<CarteirasWithOwnerListView> {
  final CarteirasWithOwnerStore _store =
      serviceLocator<CarteirasWithOwnerStore>();

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
    double phoneWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Observer(builder: (_) {
          return Expanded(
            child: ListView.builder(
              clipBehavior: Clip.none,
              shrinkWrap: true,
              itemCount: _store.carteiraList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    _store.carteiraSelected = _store.carteiraList[index],
                    _store.nextPage(),
                  },
                  child: Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.only(bottom: 16, top: 16),
                    margin: const EdgeInsets.only(bottom: 16, top: 16),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        SizedBox(
                          width: phoneWidth * .8,
                          child: Column(
                            children: [
                              _rowUser(
                                atributo: "Id",
                                value: _store.carteiraList[index].id,
                              ),
                              _rowUser(
                                atributo: "Total de sellers",
                                value:
                                    "${_store.carteiraList[index].sellers!.length}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

  Row _rowUser({required String atributo, required String value}) {
    return Row(
      children: [
        Text(
          "$atributo: ",
          style: AppTextStyles.bold(size: 14, color: AppColors.primary),
        ),
        Text(
          value,
          style: AppTextStyles.bold(size: 14, color: AppColors.black),
        ),
      ],
    );
  }
}
