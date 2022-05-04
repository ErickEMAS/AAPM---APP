// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SellerStore on _SellerStoreBase, Store {
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
  SellerModel get sellerEditModel {
    _$sellerEditModelAtom.reportRead();
    return super.sellerEditModel;
  }

  @override
  set sellerEditModel(SellerModel value) {
    _$sellerEditModelAtom.reportWrite(value, super.sellerEditModel, () {
      super.sellerEditModel = value;
    });
  }

  final _$selectedColorAtom = Atom(name: '_SellerStoreBase.selectedColor');

  @override
  Color? get selectedColor {
    _$selectedColorAtom.reportRead();
    return super.selectedColor;
  }

  @override
  set selectedColor(Color? value) {
    _$selectedColorAtom.reportWrite(value, super.selectedColor, () {
      super.selectedColor = value;
    });
  }

  final _$tagSelectedIdAtom = Atom(name: '_SellerStoreBase.tagSelectedId');

  @override
  String? get tagSelectedId {
    _$tagSelectedIdAtom.reportRead();
    return super.tagSelectedId;
  }

  @override
  set tagSelectedId(String? value) {
    _$tagSelectedIdAtom.reportWrite(value, super.tagSelectedId, () {
      super.tagSelectedId = value;
    });
  }

  final _$_SellerStoreBaseActionController =
      ActionController(name: '_SellerStoreBase');

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
  dynamic _setTagList(List<TagModel> data) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase._setTagList');
    try {
      return super._setTagList(data);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedColor(Color newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setSelectedColor');
    try {
      return super.setSelectedColor(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTagNameSelected(String newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setTagNameSelected');
    try {
      return super.setTagNameSelected(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageController: ${pageController},
currentPage: ${currentPage},
sellerModel: ${sellerModel},
sellerEditModel: ${sellerEditModel},
selectedColor: ${selectedColor},
tagSelectedId: ${tagSelectedId}
    ''';
  }
}
