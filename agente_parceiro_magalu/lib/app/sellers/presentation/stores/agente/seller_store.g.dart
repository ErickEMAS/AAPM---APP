// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SellerStore on _SellerStoreBase, Store {
  final _$sellerModelAtom = Atom(name: '_SellerStoreBase.sellerModel');

  @override
  SellerModel get sellerModel {
    _$sellerModelAtom.reportRead();
    return super.sellerModel;
  }

  @override
  set sellerModel(SellerModel value) {
    _$sellerModelAtom.reportWrite(value, super.sellerModel, () {
      super.sellerModel = value;
    });
  }

  final _$sellerEditModelAtom = Atom(name: '_SellerStoreBase.sellerEditModel');

  @override
  SellerModel? get sellerEditModel {
    _$sellerEditModelAtom.reportRead();
    return super.sellerEditModel;
  }

  @override
  set sellerEditModel(SellerModel? value) {
    _$sellerEditModelAtom.reportWrite(value, super.sellerEditModel, () {
      super.sellerEditModel = value;
    });
  }

  final _$searchClickedAtom = Atom(name: '_SellerStoreBase.searchClicked');

  @override
  bool get searchClicked {
    _$searchClickedAtom.reportRead();
    return super.searchClicked;
  }

  @override
  set searchClicked(bool value) {
    _$searchClickedAtom.reportWrite(value, super.searchClicked, () {
      super.searchClicked = value;
    });
  }

  final _$tagIdAtom = Atom(name: '_SellerStoreBase.tagId');

  @override
  String? get tagId {
    _$tagIdAtom.reportRead();
    return super.tagId;
  }

  @override
  set tagId(String? value) {
    _$tagIdAtom.reportWrite(value, super.tagId, () {
      super.tagId = value;
    });
  }

  final _$nomeSellerAtom = Atom(name: '_SellerStoreBase.nomeSeller');

  @override
  String? get nomeSeller {
    _$nomeSellerAtom.reportRead();
    return super.nomeSeller;
  }

  @override
  set nomeSeller(String? value) {
    _$nomeSellerAtom.reportWrite(value, super.nomeSeller, () {
      super.nomeSeller = value;
    });
  }

  final _$pageControllerAtom = Atom(name: '_SellerStoreBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$currentPageAtom = Atom(name: '_SellerStoreBase.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$_SellerStoreBaseActionController =
      ActionController(name: '_SellerStoreBase');

  @override
  dynamic _setEditSellerModel(SellerModel newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase._setEditSellerModel');
    try {
      return super._setEditSellerModel(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchClicked(bool newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setSearchClicked');
    try {
      return super.setSearchClicked(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setSellerList(List<SellerModel> data) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase._setSellerList');
    try {
      return super._setSellerList(data);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTagId(String? newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setTagId');
    try {
      return super.setTagId(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNomeSeller(String? newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setNomeSeller');
    try {
      return super.setNomeSeller(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextPage() {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousPage() {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sellerModel: ${sellerModel},
sellerEditModel: ${sellerEditModel},
searchClicked: ${searchClicked},
tagId: ${tagId},
nomeSeller: ${nomeSeller},
pageController: ${pageController},
currentPage: ${currentPage}
    ''';
  }
}
