import 'package:agente_parceiro_magalu/app/home/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/home/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/pages/agente/seller/page_view/widgets/swtich_tag_enum_to_color.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TagListBuilder extends StatelessWidget {
  SellerModel? sellerModel;

  TagListBuilder({
    Key? key,
    this.sellerModel,
  }) : super(key: key);

  final SellerStore _store = serviceLocator<SellerStore>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }

  _currentTags() {
    bool isSeller = sellerModel != null;
    List<Widget> list = [];

    List<TagModel> tagList = isSeller ? sellerModel!.tags! : _store.tagList;

    list.addAll(tagList.map((tag) {
      return Observer(builder: (_) {
        return GestureDetector(
          onTap: () {
            _store.setTagNameSelected(tag.id!);
          },
          child: Container(
            decoration: BoxDecoration(
              color: SwitchTagEnum.switchEnumColor(tag.color),
              border: isSeller
                  ? null
                  : Border.all(
                      color: _store.tagSelectedId == tag.id!
                          ? AppColors.white
                          : AppColors.black.withOpacity(0.4),
                      width: 2,
                    ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.space,
                vertical: 3,
              ),
              child: Text(
                tag.name,
                style: AppTextStyles.bold(
                  color: AppColors.white,
                  size: 12,
                ),
              ),
            ),
          ),
        );
      });
    }).toList());

    return list;
  }
}
