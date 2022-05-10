// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hunting_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HuntingStore on _HuntingStoreBase, Store {
  final _$huntingModelAtom = Atom(name: '_HuntingStoreBase.huntingModel');

  @override
  HuntingModel get huntingModel {
    _$huntingModelAtom.reportRead();
    return super.huntingModel;
  }

  @override
  set huntingModel(HuntingModel value) {
    _$huntingModelAtom.reportWrite(value, super.huntingModel, () {
      super.huntingModel = value;
    });
  }

  final _$pageablePageAtom = Atom(name: '_HuntingStoreBase.pageablePage');

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

  final _$huntingEditModelAtom =
      Atom(name: '_HuntingStoreBase.huntingEditModel');

  @override
  HuntingModel get huntingEditModel {
    _$huntingEditModelAtom.reportRead();
    return super.huntingEditModel;
  }

  @override
  set huntingEditModel(HuntingModel value) {
    _$huntingEditModelAtom.reportWrite(value, super.huntingEditModel, () {
      super.huntingEditModel = value;
    });
  }

  final _$pageControllerAtom = Atom(name: '_HuntingStoreBase.pageController');

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

  final _$currentPageAtom = Atom(name: '_HuntingStoreBase.currentPage');

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

  final _$_HuntingStoreBaseActionController =
      ActionController(name: '_HuntingStoreBase');

  @override
  dynamic _setPage(int value) {
    final _$actionInfo = _$_HuntingStoreBaseActionController.startAction(
        name: '_HuntingStoreBase._setPage');
    try {
      return super._setPage(value);
    } finally {
      _$_HuntingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setHuntingEditModel(HuntingModel newData) {
    final _$actionInfo = _$_HuntingStoreBaseActionController.startAction(
        name: '_HuntingStoreBase._setHuntingEditModel');
    try {
      return super._setHuntingEditModel(newData);
    } finally {
      _$_HuntingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$_HuntingStoreBaseActionController.startAction(
        name: '_HuntingStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_HuntingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetModels() {
    final _$actionInfo = _$_HuntingStoreBaseActionController.startAction(
        name: '_HuntingStoreBase.resetModels');
    try {
      return super.resetModels();
    } finally {
      _$_HuntingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setHuntingModelList(List<HuntingModel> data) {
    final _$actionInfo = _$_HuntingStoreBaseActionController.startAction(
        name: '_HuntingStoreBase._setHuntingModelList');
    try {
      return super._setHuntingModelList(data);
    } finally {
      _$_HuntingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextPage() {
    final _$actionInfo = _$_HuntingStoreBaseActionController.startAction(
        name: '_HuntingStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_HuntingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousPage() {
    final _$actionInfo = _$_HuntingStoreBaseActionController.startAction(
        name: '_HuntingStoreBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_HuntingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
huntingModel: ${huntingModel},
pageablePage: ${pageablePage},
huntingEditModel: ${huntingEditModel},
pageController: ${pageController},
currentPage: ${currentPage}
    ''';
  }
}
