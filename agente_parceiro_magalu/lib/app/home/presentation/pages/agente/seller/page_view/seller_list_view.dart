import 'package:agente_parceiro_magalu/app/home/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/home/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SellerListView extends StatefulWidget {
  const SellerListView({Key? key}) : super(key: key);

  @override
  State<SellerListView> createState() => _SellerListViewState();
}

class _SellerListViewState extends State<SellerListView> {
  final SellerStore _store = serviceLocator<SellerStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lista de Sellers",
                style: AppTextStyles.bold(),
              ),
            ],
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
  }) {
    return GestureDetector(
      onTap: () {
        _store.navigateToEditSeller(context, sellerModel.id!);
      },
      child: Column(
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
                    Wrap(
                      children: [
                        _tag(),
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _store.getTags();
                    _addTags();
                  },
                  child: Icon(Icons.add),
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

  _tag() {
    return Container(
      child: Text("teste"),
    );
  }

  _addTags() {
    return appDialog(
      context: context,
      title: Text(
        "Adicionar tags",
        style: AppTextStyles.bold(
          size: 15,
          color: AppColors.primary,
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(AppDimens.margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Tags atuais",
              style: AppTextStyles.bold(
                size: 15,
                color: AppColors.primary,
              ),
            ),
            Text(
              "Adicionar nova tag",
              style: AppTextStyles.bold(
                size: 15,
                color: AppColors.primary,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: "nome da tag",
              ),
            ),
            SizedBox(height: AppDimens.space * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ..._tags(),
              ],
            )
          ],
        ),
      ),
    );
  }

  _tags() {
    List<Widget> list = [];
    list = TagColors.values.map((e) {
      return Row(
        children: [
          _tagContainer(_switchEnumColor(e)),
        ],
      );
    }).toList();

    return list;
  }

  _switchEnumColor(TagColors color) {
    switch (color) {
      case TagColors.amarelo:
        return AppColors.amarelo;
      case TagColors.azul:
        return AppColors.azul;
      case TagColors.verde:
        return AppColors.verde;
      case TagColors.laranja:
        return AppColors.laranja;
      case TagColors.rosa:
        return AppColors.rosa;
      case TagColors.roxo:
        return AppColors.roxo;
      default:
        AppColors.primary;
    }
  }

  Widget _tagContainer(Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
