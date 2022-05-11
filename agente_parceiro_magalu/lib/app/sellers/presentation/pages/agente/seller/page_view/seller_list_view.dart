import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/search_filter_widget.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/seller_card_widget.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/swtich_tag_enum_to_color.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/tag_list_builder.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/tag_store.dart';
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
  final SellerStore _sellerStore = serviceLocator<SellerStore>();
  final TagStore _tagStore = serviceLocator<TagStore>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _tagStore.getTags();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LoadingOverlay.of(context)
            .during(
          _sellerStore.fetchNextPage(),
        )
            .whenComplete(() {
          if (_sellerStore.pageListTotalElements <=
              _sellerStore.sellerList.length) {
            SnackBarHelper.snackBar(context,
                message: "Não há mais sellers a serem listados!");
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _sellerStore.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(AppDimens.margin),
          child: Observer(builder: (_) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lista de Sellers",
                      style: AppTextStyles.bold(),
                    ),
                    IconButton(
                      onPressed: () {
                        _sellerStore
                            .setSearchClicked(!_sellerStore.searchClicked);
                      },
                      icon: Icon(
                        _sellerStore.searchClicked ? Icons.close : Icons.search,
                      ),
                    )
                  ],
                ),
                _sellerStore.searchClicked ? SearchFilterWidget() : SizedBox(),
              ],
            );
          }),
        ),
        SizedBox(height: AppDimens.margin * 2.8),
        Observer(builder: (_) {
          return Flexible(
            child: ListView.builder(
              clipBehavior: Clip.none,
              // shrinkWrap: true,
              itemCount: _sellerStore.sellerList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return SellerCardWidget(
                  sellerModel: _sellerStore.sellerList[index],
                  onAddButtonPressed: () {
                    _tagStore.getTags();
                    _addTags(sellerId: _sellerStore.sellerList[index].id!);
                  },
                );
              },
            ),
          );
        }),
        SizedBox(height: AppDimens.margin * 3)
      ],
    );
  }

  _addTags({required String sellerId}) {
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
              ..._tagsAlreadyExistents(sellerId: sellerId),
              ..._createNewTag(),
            ],
          ),
        );
      }),
    );
  }

  _tagsAlreadyExistents({required String sellerId}) {
    return [
      Text(
        "Selecione uma tag existente",
        style: AppTextStyles.bold(
          size: 15,
          color: AppColors.primary,
        ),
      ),
      SizedBox(height: AppDimens.space),
      Observer(builder: (_) {
        return TagListBuilder();
      }),
      SizedBox(height: AppDimens.margin),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            bool ret = await LoadingOverlay.of(context).during(
              _tagStore
                  .addTagInSeller(
                    sellerId: sellerId,
                  )
                  .whenComplete(
                    () => _sellerStore.onSellerInit(),
                  ),
            );
            if (ret) {
              SnackBarHelper.snackBar(
                context,
                message: "Tag foi adicionada com sucesso",
              );
            } else {
              SnackBarHelper.snackBar(
                context,
                isError: true,
                message: "Ocorreu um erro",
              );
            }
          },
          child: const Text("Adicionar tag ao Seller"),
        ),
      ),
    ];
  }

  _createNewTag() {
    return [
      SizedBox(height: AppDimens.margin),
      Text(
        "Adicionar nova tag",
        style: AppTextStyles.bold(
          size: 15,
          color: AppColors.primary,
        ),
      ),
      TextFormField(
        controller: _tagStore.tagNameController,
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
              _tagStore.addTag().whenComplete(
                    () => _tagStore.getTags(),
                  ),
            );
            if (ret) {
              SnackBarHelper.snackBar(
                context,
                message:
                    "Tag \"${_tagStore.tagModel.name}\" foi criada com sucesso",
              );
            } else {
              SnackBarHelper.snackBar(
                context,
                isError: true,
                message: "Ocorreu um erro",
              );
            }
          },
          child: const Text("Criar tag"),
        ),
      )
    ];
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
        _tagStore.tagModel.color = tagColors;
        _tagStore.setSelectedColor(color);
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: _tagStore.selectedColor == color
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
