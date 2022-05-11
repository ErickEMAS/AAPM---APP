import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/seller_card_widget.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/locators/service_locators.dart';
import '../../../../../shared/themes/app_colors.dart';
import '../../../../../shared/themes/app_text_styles.dart';
import '../../stores/carteiras_without_owner_store.dart';

class CarteirasOverwithwithOwnerView extends StatefulWidget {
  const CarteirasOverwithwithOwnerView({Key? key}) : super(key: key);

  @override
  State<CarteirasOverwithwithOwnerView> createState() =>
      _CarteirasOverwithwithOwnerViewState();
}

class _CarteirasOverwithwithOwnerViewState
    extends State<CarteirasOverwithwithOwnerView> {
  final CarteirasWithOwnerStore _store =
      serviceLocator<CarteirasWithOwnerStore>();

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: _carteiraDetail(),
      ),
    );
  }

  Form _carteiraDetail() {
    return Form(
        key: _store.formKey,
        child: Column(
          children: [
            _row(
              atributo: "Id",
              value: _store.carteiraSelected.id,
            ),
            _row(
              atributo: "Total de sellers",
              value: "${_store.carteiraSelected.sellers!.length}",
            ),
            const SizedBox(height: 16),
            _row(
              atributo: "sellers",
              value: "",
            ),
            const SizedBox(height: 16),
            Column(
              children:
                  _store.carteiraSelected.sellers!.map<SellerCardWidget>(
                (SellerModel seller) {
                  return SellerCardWidget(sellerModel: seller);
                },
              ).toList(),
            ),
          ],
        ),
      );
  }

  Row _row({required String atributo, required String value}) {
    return Row(
      children: [
        Text(
          "$atributo: ",
          style: AppTextStyles.bold(size: 12, color: AppColors.primary),
        ),
        Text(
          value,
          style: AppTextStyles.bold(size: 12, color: AppColors.black),
        ),
      ],
    );
  }

  _ListAgents() {
    return Row(
      children: [
        Text(
          "atributo: ",
          style: AppTextStyles.bold(size: 14, color: AppColors.primary),
        ),
        Text(
          "value",
          style: AppTextStyles.bold(size: 14, color: AppColors.black),
        ),
      ],
    );
  }
}
