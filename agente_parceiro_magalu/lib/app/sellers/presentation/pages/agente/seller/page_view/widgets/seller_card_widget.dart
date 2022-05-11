import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/tag_list_builder.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class SellerCardWidget extends StatelessWidget {
  final SellerModel sellerModel;
  final int? index;
  final void Function()? onAddButtonPressed;

  SellerCardWidget({
    Key? key,
    required this.sellerModel,
    this.index,
    this.onAddButtonPressed,
  }) : super(key: key);

  final SellerStore _store = serviceLocator<SellerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          _store.indexSellerSelected = index ?? _store.indexSellerSelected;
        _store.navigateToSellerOverview(context, sellerModel.id!);
      },
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.none,
            padding: EdgeInsets.all(AppDimens.space * 2),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._sellerInfoRow(
                      title: "Nome: ",
                      content: sellerModel.nome,
                    ),
                    ..._sellerInfoRow(
                      title: "Endereço: ",
                      content: sellerModel.endereco,
                    ),
                    Row(
                      children: [
                        ..._sellerInfoRow(
                          title: "Cidade: ",
                          content: sellerModel.cidade,
                        ),
                        SizedBox(width: AppDimens.space),
                        ..._sellerInfoRow(
                          title: "UF: ",
                          content: sellerModel.uf,
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimens.space),
                    ..._sellerInfoRow(
                      title: "E-mail: ",
                      content: sellerModel.email,
                    ),
                    ..._sellerInfoRow(
                      title: "Telefone: ",
                      content: sellerModel.telefone,
                    ),
                    SizedBox(height: AppDimens.space),
                    TagListBuilder(
                      sellerModel: sellerModel,
                    )
                  ],
                ),
                !_store.admin ? (onAddButtonPressed != null
                    ? ElevatedButton(
                        onPressed: onAddButtonPressed,
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(AppDimens.space),
                        ),
                      )
                    : Container()) : Container(),
              ],
            ),
          ),
          SizedBox(height: AppDimens.space * 2)
        ],
      ),
    );
  }

  _sellerInfoRow({required String title, required String content}) {
    return [
      Row(
        children: [
          Text(
            title,
            style: AppTextStyles.bold(
              size: 13,
              color: AppColors.primary,
            ),
          ),
          Text(
            content,
            style: AppTextStyles.bold(size: 13),
          ),
        ],
      ),
      SizedBox(height: AppDimens.space),
    ];
  }
}
