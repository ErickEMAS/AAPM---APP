import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../../../../core/routes/app_routes.dart';
import '../../data/datasources/account_datasource.dart';
import '../../data/models/dynamic_field_model.dart';
part 'seller_fields_store.g.dart';

class SellerFieldsStore = _SellerFieldsStoreBase with _$SellerFieldsStore;

abstract class _SellerFieldsStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();

  bool update = false;

  @observable
  DynamicFieldModel dynamicFieldModel = DynamicFieldModel(
    name: "",
    type: TypeField.TEXT,
  );

  @observable
  bool searchClicked = false;

  @action
  setSearchClicked(bool newData) {
    searchClicked = newData;
  }

  @observable
  int pageablePage = 0;

  @action
  _setPage(int value) => pageablePage = value;

  int pageableSize = 10;

  @observable
  DynamicFieldModel dynamicFieldEditModel = DynamicFieldModel(
    name: "",
    type: TypeField.TEXT,
  );

  @action
  _setDynamicFieldEditModel(DynamicFieldModel newData) {
    dynamicFieldEditModel = newData;
  }

  @observable
  String status = "";

  @action
  setStatus(String newData) {
    status = newData;
  }

  ObservableList<DynamicFieldModel> dynamicFieldModelList =
      ObservableList<DynamicFieldModel>();

  @action
  _setDynamicFieldModelList(List<DynamicFieldModel> data) {
    dynamicFieldModelList.addAll(data);
  }

  @action
  reset() {
    dynamicFieldModelList.clear();
  }

  Future<bool> onQuestionsInit() async {
    try {
      PageListModel pageList = await _datasource.getDynamicFields(
        size: pageableSize,
        page: pageablePage,
      );

      dynamicFieldModelList.clear();
      _setDynamicFieldModelList(
          pageList.content.cast<DynamicFieldModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> fetchNextPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList = await _datasource.getDynamicFields(
        size: pageableSize,
        page: pageablePage,
      );

      _setDynamicFieldModelList(
          pageList.content.cast<DynamicFieldModel>().toList());

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  Future<bool> addDynamicQuestion() async {
    try {
      await _datasource.addDynamicField(dynamicFieldModel: dynamicFieldModel);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateDynamicQuestion() async {
    try {
      await _datasource.updateDynamicField(
          dynamicFieldModel: dynamicFieldEditModel);

      return true;
    } catch (err) {
      return false;
    }
  }

  //Page view navigation
  final formKey = GlobalKey<FormState>();

  @observable
  PageController pageController = PageController();

  @observable
  int currentPage = 0;

  @action
  nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    currentPage = 1;
  }

  @action
  previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    currentPage = 0;
  }

  Future<bool> navigateToEditSeller(BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.editSeller, arguments: sellerId)
        .then(
          (value) => false,
        );
  }

  Future<bool> navigateToChecklistVisita(
      BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.checklistVisitaSeller, arguments: sellerId)
        .then(
          (value) => false,
        );
  }

  Future<bool> navigateToSellerOverview(BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.sellerOverview, arguments: sellerId)
        .then(
          (value) => false,
        );
  }
}
