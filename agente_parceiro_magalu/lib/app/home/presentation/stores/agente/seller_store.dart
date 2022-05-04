import 'package:agente_parceiro_magalu/app/home/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/home/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/home/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'seller_store.g.dart';

class SellerStore = _SellerStoreBase with _$SellerStore;

abstract class _SellerStoreBase with Store {
  final ISellerDatasource _datasource = serviceLocator<ISellerDatasource>();

  final formKey = GlobalKey<FormState>();
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

  @observable
  late SellerModel sellerEditModel;
  @action
  _setEditSellerModel(SellerModel newData) {
    sellerEditModel = newData;
  }

  ObservableList<SellerModel> sellerList = ObservableList<SellerModel>();
  @action
  _setSellerList(List<SellerModel> data) {
    sellerList.clear();
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

  Future<bool> getSellerById({required String sellerId}) async {
    try {
      SellerModel ret = await _datasource.getSellerById(sellerId: sellerId);

      _setEditSellerModel(ret);
      return true;
    } catch (err) {
      return false;
    }
  }

  //(*************)
  //tags
  //(*************)

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

  //(*************)
  //navigation
  //(*************)
  Future<bool> navigateToEditSeller(BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.editSeller, arguments: sellerId)
        .then(
          (value) => false,
        );
  }
}
