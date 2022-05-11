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

  final _$pageablePageAtom = Atom(name: '_SellerStoreBase.pageablePage');

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

  final _$adminAtom = Atom(name: '_SellerStoreBase.admin');

  @override
  bool get admin {
    _$adminAtom.reportRead();
    return super.admin;
  }

  @override
  set admin(bool value) {
    _$adminAtom.reportWrite(value, super.admin, () {
      super.admin = value;
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
  String get tagId {
    _$tagIdAtom.reportRead();
    return super.tagId;
  }

  @override
  set tagId(String value) {
    _$tagIdAtom.reportWrite(value, super.tagId, () {
      super.tagId = value;
    });
  }

  final _$searchSellerAtom = Atom(name: '_SellerStoreBase.searchSeller');

  @override
  String get searchSeller {
    _$searchSellerAtom.reportRead();
    return super.searchSeller;
  }

  @override
  set searchSeller(String value) {
    _$searchSellerAtom.reportWrite(value, super.searchSeller, () {
      super.searchSeller = value;
    });
  }

  final _$setRoleAsyncAction = AsyncAction('_SellerStoreBase.setRole');

  @override
  Future setRole() {
    return _$setRoleAsyncAction.run(() => super.setRole());
  }

  final _$_SellerStoreBaseActionController =
      ActionController(name: '_SellerStoreBase');

  @override
  dynamic setSellerModel(SellerModel newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setSellerModel');
    try {
      return super.setSellerModel(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setPage(int value) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase._setPage');
    try {
      return super._setPage(value);
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
  dynamic setTagId(String newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setTagId');
    try {
      return super.setTagId(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchSeller(String newData) {
    final _$actionInfo = _$_SellerStoreBaseActionController.startAction(
        name: '_SellerStoreBase.setSearchSeller');
    try {
      return super.setSearchSeller(newData);
    } finally {
      _$_SellerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sellerModel: ${sellerModel},
pageablePage: ${pageablePage},
admin: ${admin},
sellerEditModel: ${sellerEditModel},
searchClicked: ${searchClicked},
tagId: ${tagId},
searchSeller: ${searchSeller}
    ''';
  }
}
