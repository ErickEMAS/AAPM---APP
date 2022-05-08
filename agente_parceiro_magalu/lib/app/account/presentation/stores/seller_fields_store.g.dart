// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_fields_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SellerFieldsStore on _SellerFieldsStoreBase, Store {
  final _$dynamicFieldModelAtom =
      Atom(name: '_SellerFieldsStoreBase.dynamicFieldModel');

  @override
  DynamicFieldModel get dynamicFieldModel {
    _$dynamicFieldModelAtom.reportRead();
    return super.dynamicFieldModel;
  }

  @override
  set dynamicFieldModel(DynamicFieldModel value) {
    _$dynamicFieldModelAtom.reportWrite(value, super.dynamicFieldModel, () {
      super.dynamicFieldModel = value;
    });
  }

  final _$searchClickedAtom =
      Atom(name: '_SellerFieldsStoreBase.searchClicked');

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

  final _$pageablePageAtom = Atom(name: '_SellerFieldsStoreBase.pageablePage');

  @override
  int get pageablePage {
    _$pageablePageAtom.reportRead();
    return super.pageablePage;
  }

  @override
  set pageablePage(int value) {
    _$pageablePageAtom.reportWrite(value, super.pageablePage, () {
      super.pageablePage = value;
    });
  }

  final _$dynamicFieldEditModelAtom =
      Atom(name: '_SellerFieldsStoreBase.dynamicFieldEditModel');

  @override
  DynamicFieldModel get dynamicFieldEditModel {
    _$dynamicFieldEditModelAtom.reportRead();
    return super.dynamicFieldEditModel;
  }

  @override
  set dynamicFieldEditModel(DynamicFieldModel value) {
    _$dynamicFieldEditModelAtom.reportWrite(value, super.dynamicFieldEditModel,
        () {
      super.dynamicFieldEditModel = value;
    });
  }

  final _$statusAtom = Atom(name: '_SellerFieldsStoreBase.status');

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$pageControllerAtom =
      Atom(name: '_SellerFieldsStoreBase.pageController');

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

  final _$currentPageAtom = Atom(name: '_SellerFieldsStoreBase.currentPage');

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

  final _$_SellerFieldsStoreBaseActionController =
      ActionController(name: '_SellerFieldsStoreBase');

  @override
  dynamic setSearchClicked(bool newData) {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase.setSearchClicked');
    try {
      return super.setSearchClicked(newData);
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setPage(int value) {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase._setPage');
    try {
      return super._setPage(value);
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setDynamicFieldEditModel(DynamicFieldModel newData) {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase._setDynamicFieldEditModel');
    try {
      return super._setDynamicFieldEditModel(newData);
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStatus(String newData) {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase.setStatus');
    try {
      return super.setStatus(newData);
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setDynamicFieldModelList(List<DynamicFieldModel> data) {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase._setDynamicFieldModelList');
    try {
      return super._setDynamicFieldModelList(data);
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextPage() {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousPage() {
    final _$actionInfo = _$_SellerFieldsStoreBaseActionController.startAction(
        name: '_SellerFieldsStoreBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_SellerFieldsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dynamicFieldModel: ${dynamicFieldModel},
searchClicked: ${searchClicked},
pageablePage: ${pageablePage},
dynamicFieldEditModel: ${dynamicFieldEditModel},
status: ${status},
pageController: ${pageController},
currentPage: ${currentPage}
    ''';
  }
}
