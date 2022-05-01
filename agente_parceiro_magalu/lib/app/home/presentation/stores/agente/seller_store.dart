import 'package:agente_parceiro_magalu/app/home/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/home/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'seller_store.g.dart';

class SellerStore = _SellerStoreBase with _$SellerStore;

abstract class _SellerStoreBase with Store {
  final ISellerDatasource _datasource = serviceLocator<ISellerDatasource>();

//Page view navigation
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

  final formKey = GlobalKey<FormState>();

  int pageableSize = 15;
  int pageablePage = 0;

  @observable
  SellerModel sellerModel = SellerModel(
    cnpj: "",
    helenaSellerCode: "",
    nome: "",
    telefone: "",
    email: "",
    cidade: "",
    uf: "",
    cep: "",
    endereco: "",
    numero: "",
    complemento: "",
    cadastro: "",
    dataPedidoTeste: "",
  );

  ObservableList<SellerModel> sellerList = ObservableList<SellerModel>();

  @action
  _setSellerList(List<SellerModel> data) {
    sellerList.addAll(data);
  }

  @action
  reset() {
    sellerList.clear();
  }

  Future<bool> onSellerInit() async {
    try {
      PageListModel pageList = await _datasource.getSellerList(
        size: pageableSize,
        page: pageablePage,
      );

      _setSellerList(pageList.content.cast<SellerModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> addSeller() async {
    try {
      await _datasource.addSeller(sellerModel: sellerModel);

      return true;
    } catch (err) {
      return false;
    }
  }
}
