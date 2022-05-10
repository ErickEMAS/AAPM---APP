import 'package:agente_parceiro_magalu/app/account/data/models/hunting_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../../../../core/routes/app_routes.dart';
import '../../data/datasources/account_datasource.dart';
part 'hunting_store.g.dart';

class HuntingStore = _HuntingStoreBase with _$HuntingStore;

abstract class _HuntingStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();

  @observable
  HuntingModel huntingModel = HuntingModel(
    nome: "",
    telefone: "",
    email: "",
    cidade: "",
    uf: "",
    cep: "",
    endereco: "",
    numero: "",
    complemento: "",
  );

  @observable
  int pageablePage = 0;

  bool update = false;

  @action
  _setPage(int value) => pageablePage = value;

  int pageableSize = 25;

  @observable
  HuntingModel huntingEditModel = HuntingModel(
    nome: "",
    telefone: "",
    email: "",
    cidade: "",
    uf: "",
    cep: "",
    endereco: "",
    numero: "",
    complemento: "",
  );

  @action
  _setHuntingEditModel(HuntingModel newData) {
    huntingEditModel = newData;
  }

  @action
  reset() {
    huntingModelList.clear();

    resetModels();
  }

  @action
  resetModels() {
    huntingModel = HuntingModel(
      nome: "",
      telefone: "",
      email: "",
      cidade: "",
      uf: "",
      cep: "",
      endereco: "",
      numero: "",
      complemento: "",
    );

    huntingEditModel = HuntingModel(
      nome: "",
      telefone: "",
      email: "",
      cidade: "",
      uf: "",
      cep: "",
      endereco: "",
      numero: "",
      complemento: "",
    );
  }

  ObservableList<HuntingModel> huntingModelList =
      ObservableList<HuntingModel>();

  @action
  _setHuntingModelList(List<HuntingModel> data) {
    huntingModelList.addAll(data);
  }

  Future<bool> onHuntinInit() async {
    try {
      PageListModel pageList = await _datasource.getHuntings(
        size: pageableSize,
        page: 0,
      );

      huntingModelList.clear();
      _setHuntingModelList(pageList.content.cast<HuntingModel>().toList());
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> fetchNextPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList =
          await _datasource.getHuntings(size: pageableSize, page: pageableSize);

      _setHuntingModelList(pageList.content.cast<HuntingModel>().toList());

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  Future<bool> addHunting() async {
    try {
      var a = huntingEditModel;
      await _datasource.addHunting(huntingModel: huntingModel);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateHunting() async {
    try {
      List<HuntingModel> a = huntingModelList;
      await _datasource.updateHunting(huntingModel: huntingEditModel);

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

  Future<bool> navigateToHuntingOverview(BuildContext context) {
    return Navigator.of(context).pushNamed(AppRoutes.huntingOverview).then(
          (value) => false,
        );
  }

  String? validateRequired(String? text) {
    if (text == "" || text == null) return "Campo não pode ser vazio";
    return null;
  }

  void navigateback(BuildContext context) {
    return Navigator.pop(context);
  }
}
