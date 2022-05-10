// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteiras_without_owner_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarteirasWithOwnerStore on _CarteirasWithOwnerStoreBase, Store {
  final _$carteiraSelectedAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.carteiraSelected');

  @override
  CarteiraModel get carteiraSelected {
    _$carteiraSelectedAtom.reportRead();
    return super.carteiraSelected;
  }

  @override
  set carteiraSelected(CarteiraModel value) {
    _$carteiraSelectedAtom.reportWrite(value, super.carteiraSelected, () {
      super.carteiraSelected = value;
    });
  }

  final _$agentModelAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.agentModel');

  @override
  UserAgentModel get agentModel {
    _$agentModelAtom.reportRead();
    return super.agentModel;
  }

  @override
  set agentModel(UserAgentModel value) {
    _$agentModelAtom.reportWrite(value, super.agentModel, () {
      super.agentModel = value;
    });
  }

  final _$pageablePageAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.pageablePage');

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

  final _$pageControllerAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.pageController');

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

  final _$currentPageAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.currentPage');

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

  final _$onQuestionsInitAsyncAction =
      AsyncAction('_CarteirasWithOwnerStoreBase.onQuestionsInit');

  @override
  Future<bool> onQuestionsInit() {
    return _$onQuestionsInitAsyncAction.run(() => super.onQuestionsInit());
  }

  final _$_CarteirasWithOwnerStoreBaseActionController =
      ActionController(name: '_CarteirasWithOwnerStoreBase');

  @override
  dynamic reset() {
    final _$actionInfo = _$_CarteirasWithOwnerStoreBaseActionController
        .startAction(name: '_CarteirasWithOwnerStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setPage(int value) {
    final _$actionInfo = _$_CarteirasWithOwnerStoreBaseActionController
        .startAction(name: '_CarteirasWithOwnerStoreBase._setPage');
    try {
      return super._setPage(value);
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextPage() {
    final _$actionInfo = _$_CarteirasWithOwnerStoreBaseActionController
        .startAction(name: '_CarteirasWithOwnerStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousPage() {
    final _$actionInfo = _$_CarteirasWithOwnerStoreBaseActionController
        .startAction(name: '_CarteirasWithOwnerStoreBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setcarteiraList(List<CarteiraModel> data) {
    final _$actionInfo = _$_CarteirasWithOwnerStoreBaseActionController
        .startAction(name: '_CarteirasWithOwnerStoreBase._setcarteiraList');
    try {
      return super._setcarteiraList(data);
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
carteiraSelected: ${carteiraSelected},
agentModel: ${agentModel},
pageablePage: ${pageablePage},
pageController: ${pageController},
currentPage: ${currentPage}
    ''';
  }
}
