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
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../../../core/snackbar_helper.dart';
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
    sellerList.clear();
  }

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
      );

      _setSellerList(pageList.content.cast<SellerModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> fetchNextPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList = await _datasource.getSellerList(
        size: pageableSize,
        page: pageablePage,
      );

      _setSellerList(pageList.content.cast<SellerModel>().toList());

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

  Future<bool> addSeller() async {
    try {
      await _datasource.addSeller(sellerModel: sellerModel);

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
