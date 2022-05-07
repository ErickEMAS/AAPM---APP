import 'package:agente_parceiro_magalu/app/account/presentation/stores/my_tags_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';
import '../../../../../core/snackbar_helper.dart';
import '../../../../../shared/themes/app_colors.dart';
import '../../../../../shared/themes/app_text_styles.dart';
import '../../../../../shared/widgets/app_dialog_widget.dart';
import '../../../../sellers/presentation/pages/agente/seller/page_view/widgets/swtich_tag_enum_to_color.dart';

class MyTagsPage extends StatefulWidget {
  const MyTagsPage({Key? key}) : super(key: key);

  @override
  State<MyTagsPage> createState() => _MyTagsPageState();
}

class _MyTagsPageState extends State<MyTagsPage> {
  final MyTagsStore _store = serviceLocator<MyTagsStore>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _store.reset();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onTagInit());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Observer(
        builder: (_) {
          return Scaffold(
            backgroundColor: AppColors.lightGrey,
            appBar: const AppBarGradient(
              title: "Minhas Tags",
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _createNewTag();
                  },
                  child: const Text("Adicionar nova Tag"),
                ),
              ),
            ),
            body: _store.tagList.isNotEmpty
                ? Observer(
                    builder: (_) {
                      return ListView.builder(
                        itemCount: _store.tagList.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                _editTag(tagModel: _store.tagList[index]),
                            child: Container(
                              height: 60,
                              color: AppColors.white,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.bookmark,
                                    color: SwitchTagEnum.switchEnumColor(
                                        _store.tagList[index].color),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 16),
                                  Text(_store.tagList[index].name),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : const Text("Nenhuma tag localizada"),
            bottomNavigationBar: AppBottomBar(),
          );
        },
      ),
    );
  }

  _createNewTag() {
    _store.tagNameController.clear();
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
                      _store.addTag().whenComplete(
                            () => _store.navigateback(context),
                          ),
                    );
                    if (ret) {
                      SnackBarHelper.snackBar(
                        context,
                        message: "Tag criada com sucesso",
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
            ],
          ),
        );
      }),
    );
  }

  _editTag({required TagModel tagModel}) {
    _store.tagNameController.text = tagModel.name;
    _store.tagModel = tagModel;

    return appDialog(
      context: context,
      title: Text(
        "Editar tags",
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
                      _store.updateTag().whenComplete(
                            () => _store.navigateback(context),
                          ),
                    );
                    if (ret) {
                      SnackBarHelper.snackBar(
                        context,
                        message: "Tag editada com sucesso",
                      );
                    } else {
                      SnackBarHelper.snackBar(
                        context,
                        isError: true,
                        message: "Ocorreu um erro",
                      );
                    }
                  },
                  child: const Text("Editar tag"),
                ),
              )
            ],
          ),
        );
      }),
    );
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
