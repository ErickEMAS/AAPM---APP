import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'tag_store.g.dart';

class TagStore = _TagStoreBase with _$TagStore;

abstract class _TagStoreBase with Store {
  final ISellerDatasource _datasource = serviceLocator<ISellerDatasource>();

  TagModel tagModel = TagModel(name: "", color: TagColors.amarelo);

  TextEditingController tagNameController = TextEditingController();

  ObservableList<TagModel> tagList = ObservableList<TagModel>();
  @action
  _setTagList(List<TagModel> data) {
    tagList.clear();
    tagList.addAll(data);
  }

  @observable
  Color? selectedColor;
  
  @action
  setSelectedColor(Color newData) {
    selectedColor = newData;
  }

  @observable
  String? tagSelectedId;
  @action
  setTagNameSelected(String newData) {
    tagSelectedId = newData;
  }

  Future<bool> getTags() async {
    try {
      var ret = await _datasource.getTags();
      _setTagList(ret);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> addTag() async {
    try {
      tagModel.name = tagNameController.text;
      await _datasource.addTag(tagModel: tagModel);
      _tagCreateReset();
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> addTagInSeller({
    required String sellerId,
  }) async {
    try {
      await _datasource.addTagInSeller(
        tagId: tagSelectedId!,
        sellerId: sellerId,
      );
      return true;
    } catch (err) {
      return false;
    }
  }

  _tagCreateReset() {
    tagNameController = TextEditingController();
    selectedColor = null;
  }
}
