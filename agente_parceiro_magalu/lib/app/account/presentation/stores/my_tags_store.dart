import 'package:agente_parceiro_magalu/app/sellers/data/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../../data/datasources/account_datasource.dart';
part 'my_tags_store.g.dart';

class MyTagsStore = _MyTagsStoreBase with _$MyTagsStore;

abstract class _MyTagsStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();
  
  final formKey = GlobalKey<FormState>();
  
  @observable
  PageController pageController = PageController();

  TagModel tagModel = TagModel(name: "", color: TagColors.amarelo);

  TextEditingController tagNameController = TextEditingController();

  ObservableList<TagModel> tagList = ObservableList<TagModel>();

  @observable
  Color? selectedColor;

  @action
  Future<bool> onTagInit() async {
    try {
      var ret = await _datasource.getTagList();
      _setTagList(ret);

      return true;
    } catch (err) {
      return false;
    }
  }

  @action
  reset() {
    pageController.initialPage;

    tagModel = TagModel(name: "", color: TagColors.amarelo);

    tagNameController.clear();
    
    tagList.clear();
  }
  
  @action
  setSelectedColor(Color newData) {
    selectedColor = newData;
  }

  @action
  _setTagList(List<TagModel> data) {
    tagList.clear();
    tagList.addAll(data);
  }

  Future<bool> addTag() async {
    try {
      tagModel.name = tagNameController.text;
      await _datasource.addTag(tagModel: tagModel);
        onTagInit();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateTag() async {
    try {
      tagModel.name = tagNameController.text;
      await _datasource.updateTag(tagModel: tagModel);
        onTagInit();
      return true;
    } catch (err) {
      return false;
    }
  }

  void navigateback(BuildContext context) {
    return Navigator.pop(context);
  }

}
