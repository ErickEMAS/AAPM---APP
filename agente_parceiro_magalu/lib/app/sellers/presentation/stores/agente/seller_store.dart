import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'seller_store.g.dart';

class SellerStore = _SellerStoreBase with _$SellerStore;

abstract class _SellerStoreBase with Store {
  final ISellerDatasource _datasource = serviceLocator<ISellerDatasource>();

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
  @action
  setSellerModel(SellerModel newData) {
    sellerModel = newData;
  }

  @observable
  int pageablePage = 0;

  @action
  _setPage(int value) => pageablePage = value;

  int pageableSize = 5;

  @observable
  SellerModel? sellerEditModel;
  @action
  _setEditSellerModel(SellerModel newData) {
    sellerEditModel = newData;
  }

  @observable
  bool searchClicked = false;
  @action
  setSearchClicked(bool newData) {
    searchClicked = newData;
  }

  ObservableList<SellerModel> sellerList = ObservableList<SellerModel>();
  @action
  _setSellerList(List<SellerModel> data) {
    sellerList.addAll(data);
  }

  @action
  reset() {
    // sellerList.clear();
    setSearchClicked(false);
    _setPage(0);
  }

  int pageListTotalElements = 0;

  Future<bool> onSellerInit() async {
    try {
      PageListModel pageList = await _datasource.getSellerList(
        size: pageableSize,
        page: pageablePage,
      );

      pageListTotalElements = pageList.totalElements;

      print(pageListTotalElements);

      _setSellerList(pageList.content.cast<SellerModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<SellerModel>?> getAllSellers() async {
    try {
      PageListModel pageList = await _datasource.getSellerList();

      List<SellerModel>? seller = pageList.content.cast<SellerModel>().toList();

      return seller;
    } catch (err) {
      print(err);
      // return false;
    }
  }

  Future<bool> fetchNextPage() async {
    try {
      if (pageListTotalElements > sellerList.length) {
        _setPage(pageablePage + 1);

        PageListModel pageList = await _datasource.getSellerList(
          size: pageableSize,
          page: pageablePage,
        );

        _setSellerList(pageList.content.cast<SellerModel>().toList());
        print(pageListTotalElements);
      }

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  @observable
  String? tagId;
  @action
  setTagId(String? newData) {
    tagId = newData;
  }

  @observable
  String? nomeSeller;
  @action
  setNomeSeller(String? newData) {
    nomeSeller = newData;
  }

  Future<bool> getSellersWithFilter() async {
    try {
      PageListModel pageList = await _datasource.getSellerList(
        size: pageableSize,
        page: pageablePage,
        tagId: tagId,
        nome: nomeSeller,
      );

      _setSellerList(pageList.content.cast<SellerModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> addSeller({
    SellerModel? sellerModelFromSheet,
  }) async {
    try {
      sellerModelFromSheet != null
          ? await _datasource.addSeller(sellerModel: sellerModelFromSheet)
          : await _datasource.addSeller(sellerModel: sellerModel);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> getSellerById({required String sellerId}) async {
    try {
      SellerModel ret = await _datasource.getSellerById(sellerId: sellerId);

      _setEditSellerModel(ret);
      return true;
    } catch (err) {
      return false;
    }
  }

  TextEditingController nomeController = TextEditingController();
  TextEditingController helenaController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController cadastroController = TextEditingController();
  TextEditingController dataPedidoController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();

  void fillAddSeller() {
    cnpjController.text = sellerModel.cnpj;
    nomeController.text = sellerModel.nome;
    helenaController.text = sellerModel.helenaSellerCode;
    telefoneController.text = sellerModel.telefone;
    emailController.text = sellerModel.email;
    cidadeController.text = sellerModel.cidade;
    cepController.text = sellerModel.cep;
    enderecoController.text = sellerModel.endereco;
    numeroController.text = sellerModel.numero;
    complementoController.text = sellerModel.complemento;
    cadastroController.text = sellerModel.cadastro;
    dataPedidoController.text = sellerModel.dataPedidoTeste;
  }

  void cleanAddSeller() {
    nomeController = TextEditingController();
    helenaController = TextEditingController();
    telefoneController = TextEditingController();
    emailController = TextEditingController();
    cidadeController = TextEditingController();
    cepController = TextEditingController();
    enderecoController = TextEditingController();
    numeroController = TextEditingController();
    complementoController = TextEditingController();
    cadastroController = TextEditingController();
    dataPedidoController = TextEditingController();
    cnpjController = TextEditingController();
  }

  //Page view navigation

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
