import 'package:agente_parceiro_magalu/app/account/data/models/hunting_model.dart';
import 'package:agente_parceiro_magalu/app/account/presentation/stores/hunting_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class HuntingCardWidget extends StatelessWidget {
  final HuntingModel huntingModel;

  HuntingCardWidget({
    Key? key,
    required this.huntingModel
  }) : super(key: key);

  final HuntingStore _store = serviceLocator<HuntingStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _store.huntingEditModel = huntingModel;
        _store.navigateToHuntingOverview(context);
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
                      content: huntingModel.nome!,
                    ),
                    ..._sellerInfoRow(
                      title: "Endereço: ",
                      content: huntingModel.endereco!,
                    ),
                    Row(
                      children: [
                        ..._sellerInfoRow(
                          title: "Cidade: ",
                          content: huntingModel.cidade!,
                        ),
                        SizedBox(width: AppDimens.space),
                        ..._sellerInfoRow(
                          title: "UF: ",
                          content: huntingModel.uf!,
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimens.space),
                  ],
                ),
                // ElevatedButton(
                //   onPressed: onAddButtonPressed,
                //   child: const Icon(Icons.add),
                //   style: ElevatedButton.styleFrom(
                //     shape: const CircleBorder(),
                //     padding: EdgeInsets.all(AppDimens.space),
                //   ),
                // ),
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
