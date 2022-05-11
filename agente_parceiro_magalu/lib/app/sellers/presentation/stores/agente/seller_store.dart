import 'dart:io';

import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
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
  );
  @action
  setSellerModel(SellerModel newData) {
    sellerModel = newData;
  }

  @observable
  int pageablePage = -1;

  @action
  _setPage(int value) => pageablePage = value;

  int pageableSize = 20;

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

  Future<String?> readSheets({required BuildContext context}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    PlatformFile file = result!.files.first;

    var bytes = File(file.path!).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<Map<String, dynamic>> mapList = [];

    for (var table in excel.tables.keys) {
      for (int i = 0; i < excel.tables[table]!.rows.length; i++) {
        var row = excel.tables[table]!.rows[i];
        Map<String, dynamic> map = {};
        for (int j = 0; j < row.length; j++) {
          var value = row[j]?.value;
          if (i > 0) {
            map["${excel.tables[table]!.rows[0][j]!.value}"] = "${value}";
          }
        }
        if (i > 0) {
          mapList.add(map);
        }
      }
    }

    List<SellerModel> sellers =
        mapList.map((e) => SellerModel.fromJson(e)).toList();

    var ret = await _datasource.addSellerList(sellerModelList: sellers);

    if (ret != null) return ret;
  }

  Future forceGetSellers() async {
    pageableSize = 500;
    await onSellerInit();
  }

  Future<bool> onSellerInit() async {
    try {
      PageListModel pageList = await _datasource.getSellerList(
        size: pageableSize,
        page: pageablePage,
        search: searchSeller,
        tagId: tagId,
      );

      pageListTotalElements = pageList.totalElements;

      print(pageListTotalElements);

      sellerList.clear();
      _setSellerList(pageList.content.cast<SellerModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<SellerModel>?> getAllSellers() async {
    try {
      PageListModel pageList = await _datasource.getSellerList(search: "");

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
          search: searchSeller,
          tagId: tagId,
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
  String tagId = "";
  @action
  setTagId(String newData) {
    tagId = newData;
  }

  @observable
  String searchSeller = "";
  @action
  setSearchSeller(String newData) {
    searchSeller = newData;
  }

  // Future<bool> getSellersWithFilter() async {
  //   try {
  //     PageListModel pageList = await _datasource.getSellerList(
  //       size: pageableSize,
  //       page: pageablePage,
  //       tagId: tagId,
  //       search: nomeSeller,
  //     );

  //     _setSellerList(pageList.content.cast<SellerModel>().toList());

  //     return true;
  //   } catch (err) {
  //     return false;
  //   }
  // }

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

  Future<bool> navigateToHistoricoChecklist(
      BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.checklistHistorico, arguments: sellerId)
        .then((value) => true);
  }
}
