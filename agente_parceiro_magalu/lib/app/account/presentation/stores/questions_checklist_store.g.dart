// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_checklist_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuestionChecklistStore on _QuestionChecklistStoreBase, Store {
  final _$dynamicQuestionCheckListModelAtom =
      Atom(name: '_QuestionChecklistStoreBase.dynamicQuestionCheckListModel');

  @override
  DynamicQuestionCheckListModel get dynamicQuestionCheckListModel {
    _$dynamicQuestionCheckListModelAtom.reportRead();
    return super.dynamicQuestionCheckListModel;
  }

  @override
  set dynamicQuestionCheckListModel(DynamicQuestionCheckListModel value) {
    _$dynamicQuestionCheckListModelAtom
        .reportWrite(value, super.dynamicQuestionCheckListModel, () {
      super.dynamicQuestionCheckListModel = value;
    });
  }

  final _$statusAtom = Atom(name: '_QuestionChecklistStoreBase.status');

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

  final _$searchClickedAtom =
      Atom(name: '_QuestionChecklistStoreBase.searchClicked');

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

  final _$pageablePageAtom =
      Atom(name: '_QuestionChecklistStoreBase.pageablePage');

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
      Atom(name: '_QuestionChecklistStoreBase.pageController');

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
      Atom(name: '_QuestionChecklistStoreBase.currentPage');

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

  final _$dynamicQuestionCheckListEditModelAtom = Atom(
      name: '_QuestionChecklistStoreBase.dynamicQuestionCheckListEditModel');

  @override
  DynamicQuestionCheckListModel get dynamicQuestionCheckListEditModel {
    _$dynamicQuestionCheckListEditModelAtom.reportRead();
    return super.dynamicQuestionCheckListEditModel;
  }

  @override
  set dynamicQuestionCheckListEditModel(DynamicQuestionCheckListModel value) {
    _$dynamicQuestionCheckListEditModelAtom
        .reportWrite(value, super.dynamicQuestionCheckListEditModel, () {
      super.dynamicQuestionCheckListEditModel = value;
    });
  }

  final _$onQuestionsInitAsyncAction =
      AsyncAction('_QuestionChecklistStoreBase.onQuestionsInit');

  @override
  Future<bool> onQuestionsInit() {
    return _$onQuestionsInitAsyncAction.run(() => super.onQuestionsInit());
  }

  final _$_QuestionChecklistStoreBaseActionController =
      ActionController(name: '_QuestionChecklistStoreBase');

  @override
  dynamic reset() {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetmodels() {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.resetmodels');
    try {
      return super.resetmodels();
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchClicked(bool newData) {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.setSearchClicked');
    try {
      return super.setSearchClicked(newData);
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setPage(int value) {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase._setPage');
    try {
      return super._setPage(value);
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setDynamicQuestionCheckListEditModel(
      DynamicQuestionCheckListModel newData) {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController.startAction(
        name:
            '_QuestionChecklistStoreBase._setDynamicQuestionCheckListEditModel');
    try {
      return super._setDynamicQuestionCheckListEditModel(newData);
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addNewAlternative() {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.addNewAlternative');
    try {
      return super.addNewAlternative();
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeAlternative({required AlternativeModel alternativeModel}) {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.removeAlternative');
    try {
      return super.removeAlternative(alternativeModel: alternativeModel);
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextPage() {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousPage() {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStatus(String newData) {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController
        .startAction(name: '_QuestionChecklistStoreBase.setStatus');
    try {
      return super.setStatus(newData);
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setDynamicQuestionCheckListEditModelList(
      List<DynamicQuestionCheckListModel> data) {
    final _$actionInfo = _$_QuestionChecklistStoreBaseActionController.startAction(
        name:
            '_QuestionChecklistStoreBase._setDynamicQuestionCheckListEditModelList');
    try {
      return super._setDynamicQuestionCheckListEditModelList(data);
    } finally {
      _$_QuestionChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dynamicQuestionCheckListModel: ${dynamicQuestionCheckListModel},
status: ${status},
searchClicked: ${searchClicked},
pageablePage: ${pageablePage},
pageController: ${pageController},
currentPage: ${currentPage},
dynamicQuestionCheckListEditModel: ${dynamicQuestionCheckListEditModel}
    ''';
  }
}
