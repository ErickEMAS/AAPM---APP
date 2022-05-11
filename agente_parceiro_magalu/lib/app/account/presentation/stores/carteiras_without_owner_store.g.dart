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

  final _$pageablePageAgentAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.pageablePageAgent');

  @override
  int get pageablePageAgent {
    _$pageablePageAgentAtom.reportRead();
    return super.pageablePageAgent;
  }

  @override
  set pageablePageAgent(int value) {
    _$pageablePageAgentAtom.reportWrite(value, super.pageablePageAgent, () {
      super.pageablePageAgent = value;
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

  final _$searchClickedAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.searchClicked');

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

  final _$searchAtom = Atom(name: '_CarteirasWithOwnerStoreBase.search');

  @override
  String? get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String? value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  final _$userAgentselectedAtom =
      Atom(name: '_CarteirasWithOwnerStoreBase.userAgentselected');

  @override
  UserAgentModel get userAgentselected {
    _$userAgentselectedAtom.reportRead();
    return super.userAgentselected;
  }

  @override
  set userAgentselected(UserAgentModel value) {
    _$userAgentselectedAtom.reportWrite(value, super.userAgentselected, () {
      super.userAgentselected = value;
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
  dynamic setSearch(String? newData) {
    final _$actionInfo = _$_CarteirasWithOwnerStoreBaseActionController
        .startAction(name: '_CarteirasWithOwnerStoreBase.setSearch');
    try {
      return super.setSearch(newData);
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchClicked(bool newData) {
    final _$actionInfo = _$_CarteirasWithOwnerStoreBaseActionController
        .startAction(name: '_CarteirasWithOwnerStoreBase.setSearchClicked');
    try {
      return super.setSearchClicked(newData);
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setUserAgenteModelList(List<UserAgentModel> data) {
    final _$actionInfo =
        _$_CarteirasWithOwnerStoreBaseActionController.startAction(
            name: '_CarteirasWithOwnerStoreBase._setUserAgenteModelList');
    try {
      return super._setUserAgenteModelList(data);
    } finally {
      _$_CarteirasWithOwnerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

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
pageablePageAgent: ${pageablePageAgent},
pageController: ${pageController},
currentPage: ${currentPage},
searchClicked: ${searchClicked},
search: ${search},
userAgentselected: ${userAgentselected}
    ''';
  }
}
