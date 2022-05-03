import 'package:agente_parceiro_magalu/app/home/presentation/pages/agente/seller/page_view/widgets/seller_card_widget.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/agente/seller/page_view/widgets/swtich_tag_enum_to_color.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
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
                return SellerCardWidget(
                    sellerModel: _store.sellerList[index],
                    onAddButtonPressed: () {
                      _store.getTags();
                      _addTags();
                    });
                // return _sellerCard(
                //   sellerModel: _store.sellerList[index],
                // );
              },
            ),
          );
        }),
        SizedBox(height: AppDimens.margin * 3)
      ],
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
      content: Observer(builder: (_) {
        return Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Tags atuais",
                style: AppTextStyles.bold(
                  size: 15,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: AppDimens.space),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.63,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: AppDimens.space,
                  runSpacing: AppDimens.space * 0.5,
                  children: [
                    ..._currentTags(),
                  ],
                ),
              ),
              SizedBox(height: AppDimens.margin),
              Text(
                "Adicionar nova tag",
                style: AppTextStyles.bold(
                  size: 15,
                  color: AppColors.primary,
                ),
              ),
              TextFormField(
                controller: _store.tagNameController,
                decoration: const InputDecoration(
                  hintText: "Nome da tag",
                  labelText: "Nome",
                ),
              ),
              SizedBox(height: AppDimens.space * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ..._tags(),
                ],
              ),
              SizedBox(height: AppDimens.space * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool ret = await LoadingOverlay.of(context).during(
                      _store.addTags().whenComplete(
                            () => _store.getTags(),
                          ),
                    );
                    if (ret) {
                      SnackBarHelper.snackBar(
                        context,
                        message:
                            "Tag \"${_store.tagModel.name}\" foi criada com sucesso",
                      );
                    } else {
                      SnackBarHelper.snackBar(
                        context,
                        isError: true,
                        message: "Ocorreu um erro",
                      );
                    }
                  },
                  child: const Text("Adicionar"),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  _currentTags() {
    List<Widget> list = [];
    list.addAll(_store.tagList.map((tag) {
      return Container(
        decoration: BoxDecoration(
            color: SwitchTagEnum.switchEnumColor(tag.color),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.space,
            vertical: 3,
          ),
          child: Text(
            tag.name,
            style: AppTextStyles.bold(color: AppColors.white, size: 12),
          ),
        ),
      );
    }).toList());

    return list;
  }

  _tags() {
    List<Widget> list = [];
    list = TagColors.values.map((e) {
      return Row(
        children: [
          _tagContainer(
            color: SwitchTagEnum.switchEnumColor(e),
            tagColors: e,
          ),
        ],
      );
    }).toList();

    return list;
  }

  Widget _tagContainer({required Color color, required TagColors tagColors}) {
    return GestureDetector(
      onTap: () {
        _store.tagModel.color = tagColors;
        _store.setSelectedColor(color);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: _store.selectedColor == color
                ? AppColors.white
                : AppColors.black.withOpacity(0.4),
            width: 2,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
