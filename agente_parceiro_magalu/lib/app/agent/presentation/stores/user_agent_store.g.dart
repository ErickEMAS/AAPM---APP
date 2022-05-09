// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_agent_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserAgentStore on _UserAgentStoreBase, Store {
  final _$userAgentModelAtom = Atom(name: '_UserAgentStoreBase.userAgentModel');

  @override
  UserAgentModel get userAgentModel {
    _$userAgentModelAtom.reportRead();
    return super.userAgentModel;
  }

  @override
  set userAgentModel(UserAgentModel value) {
    _$userAgentModelAtom.reportWrite(value, super.userAgentModel, () {
      super.userAgentModel = value;
    });
  }

  final _$roleAtom = Atom(name: '_UserAgentStoreBase.role');

  @override
  String? get role {
    _$roleAtom.reportRead();
    return super.role;
  }

  @override
  set role(String? value) {
    _$roleAtom.reportWrite(value, super.role, () {
      super.role = value;
    });
  }

  final _$searchClickedAtom = Atom(name: '_UserAgentStoreBase.searchClicked');

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

  final _$pageablePageAtom = Atom(name: '_UserAgentStoreBase.pageablePage');

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

  final _$pageControllerAtom = Atom(name: '_UserAgentStoreBase.pageController');

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

  final _$currentPageAtom = Atom(name: '_UserAgentStoreBase.currentPage');

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

  final _$userAgentselectedAtom =
      Atom(name: '_UserAgentStoreBase.userAgentselected');

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

  final _$onUsersInitAsyncAction =
      AsyncAction('_UserAgentStoreBase.onUsersInit');

  @override
  Future<bool> onUsersInit() {
    return _$onUsersInitAsyncAction.run(() => super.onUsersInit());
  }

  final _$_UserAgentStoreBaseActionController =
      ActionController(name: '_UserAgentStoreBase');

  @override
  dynamic reset() {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetmodels() {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase.resetmodels');
    try {
      return super.resetmodels();
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchClicked(bool newData) {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase.setSearchClicked');
    try {
      return super.setSearchClicked(newData);
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setPage(int value) {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase._setPage');
    try {
      return super._setPage(value);
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setUserAgentselected(UserAgentModel newData) {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase._setUserAgentselected');
    try {
      return super._setUserAgentselected(newData);
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextPage() {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousPage() {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setUserAgenteModelList(List<UserAgentModel> data) {
    final _$actionInfo = _$_UserAgentStoreBaseActionController.startAction(
        name: '_UserAgentStoreBase._setUserAgenteModelList');
    try {
      return super._setUserAgenteModelList(data);
    } finally {
      _$_UserAgentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userAgentModel: ${userAgentModel},
role: ${role},
searchClicked: ${searchClicked},
pageablePage: ${pageablePage},
pageController: ${pageController},
currentPage: ${currentPage},
userAgentselected: ${userAgentselected}
    ''';
  }
}
