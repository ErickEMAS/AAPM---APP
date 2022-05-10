import 'package:agente_parceiro_magalu/app/sellers/presentation/pages/agente/seller/page_view/widgets/swtich_tag_enum_to_color.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/tag_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({Key? key}) : super(key: key);

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  final SellerStore _sellerStore = serviceLocator<SellerStore>();
  final TagStore _tagStore = serviceLocator<TagStore>();

  String? dropdownSelection;
  TextEditingController nomeSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          TextFormField(
            controller: nomeSearchController,
            decoration: const InputDecoration(
              labelText: "Pesquisar",
              hintText: "Pesquisar do seller",
            ),
            onChanged: (value) {
              _sellerStore.setSearchSeller(value);
              _sellerStore.onSellerInit();
            },
          ),
          SizedBox(height: AppDimens.space),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.56,
                child: AppDropdown(
                  customItems: _tagStore.tagList.map((tag) {
                    return DropdownMenuItem(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: AppDimens.space),
                        decoration: BoxDecoration(
                            color: SwitchTagEnum.switchEnumColor(
                              tag.color,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          tag.name,
                          style: AppTextStyles.regular(
                            size: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        _sellerStore.setTagId(tag.id == null ? "" : tag.id!);
                      },
                      value: tag.name,
                    );
                  }).toList(),
                  onChange: (value) {
                    setState(() {
                      dropdownSelection = value;
                      _sellerStore.onSellerInit();
                    });
                  },
                  value: dropdownSelection,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: ElevatedButton(
                  onPressed: () {
                    dropdownSelection = null;
                    nomeSearchController.text = ("");
                    _sellerStore.setTagId("");
                    _sellerStore.setSearchSeller("");
                    _sellerStore.onSellerInit();
                  },
                  child: const FittedBox(
                    child: Text(
                      "limpar",
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}
