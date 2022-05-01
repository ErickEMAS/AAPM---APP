import 'package:agente_parceiro_magalu/app/home/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SellerListView extends StatelessWidget {
  SellerListView({Key? key}) : super(key: key);

  final SellerStore _store = serviceLocator<SellerStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Text(
            "Lista de Sellers",
            style: AppTextStyles.bold(),
          ),
        ),
        Observer(builder: (_) {
          return Expanded(
            child: ListView.builder(
              itemCount: _store.sellerList.length,
              padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
              itemBuilder: (context, index) {
                return _sellerCard(
                  sellerModel: _store.sellerList[index],
                );
              },
            ),
          );
        }),
        SizedBox(height: AppDimens.margin * 3)
      ],
    );
  }

  _sellerCard({
    required SellerModel sellerModel,
    // required int index,
  }) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.none,
          padding: EdgeInsets.all(AppDimens.space * 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.inputHint.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
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
                    title: "Email: ",
                    content: sellerModel.email,
                  ),
                  ..._sellerInfoRow(
                    title: "Telefone: ",
                    content: sellerModel.telefone,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.edit),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(AppDimens.space),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: AppDimens.space * 2)
      ],
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
