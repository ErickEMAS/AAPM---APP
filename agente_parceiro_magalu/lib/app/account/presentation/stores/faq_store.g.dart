// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FAQStore on _FAQStoreBase, Store {
  final _$userRoleAtom = Atom(name: '_FAQStoreBase.userRole');

  @override
  String get userRole {
    _$userRoleAtom.reportRead();
    return super.userRole;
  }

  @override
  set userRole(String value) {
    _$userRoleAtom.reportWrite(value, super.userRole, () {
      super.userRole = value;
    });
  }

  final _$faqModelAtom = Atom(name: '_FAQStoreBase.faqModel');

  @override
  FAQModel get faqModel {
    _$faqModelAtom.reportRead();
    return super.faqModel;
  }

  @override
  set faqModel(FAQModel value) {
    _$faqModelAtom.reportWrite(value, super.faqModel, () {
      super.faqModel = value;
    });
  }

  final _$pageablePageAtom = Atom(name: '_FAQStoreBase.pageablePage');

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

  final _$faqEditModelAtom = Atom(name: '_FAQStoreBase.faqEditModel');

  @override
  FAQModel get faqEditModel {
    _$faqEditModelAtom.reportRead();
    return super.faqEditModel;
  }

  @override
  set faqEditModel(FAQModel value) {
    _$faqEditModelAtom.reportWrite(value, super.faqEditModel, () {
      super.faqEditModel = value;
    });
  }

  final _$searchFAQAtom = Atom(name: '_FAQStoreBase.searchFAQ');

  @override
  String? get searchFAQ {
    _$searchFAQAtom.reportRead();
    return super.searchFAQ;
  }

  @override
  set searchFAQ(String? value) {
    _$searchFAQAtom.reportWrite(value, super.searchFAQ, () {
      super.searchFAQ = value;
    });
  }

  final _$pageControllerAtom = Atom(name: '_FAQStoreBase.pageController');

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

  final _$currentPageAtom = Atom(name: '_FAQStoreBase.currentPage');

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

  final _$_FAQStoreBaseActionController =
      ActionController(name: '_FAQStoreBase');

  @override
  dynamic _setPage(int value) {
    final _$actionInfo = _$_FAQStoreBaseActionController.startAction(
        name: '_FAQStoreBase._setPage');
    try {
      return super._setPage(value);
    } finally {
      _$_FAQStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setFAQEditModel(FAQModel newData) {
    final _$actionInfo = _$_FAQStoreBaseActionController.startAction(
        name: '_FAQStoreBase._setFAQEditModel');
    try {
      return super._setFAQEditModel(newData);
    } finally {
      _$_FAQStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$_FAQStoreBaseActionController.startAction(
        name: '_FAQStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_FAQStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchFAQ(String? newData) {
    final _$actionInfo = _$_FAQStoreBaseActionController.startAction(
        name: '_FAQStoreBase.setSearchFAQ');
    try {
      return super.setSearchFAQ(newData);
    } finally {
      _$_FAQStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setFAQList(List<FAQModel> data) {
    final _$actionInfo = _$_FAQStoreBaseActionController.startAction(
        name: '_FAQStoreBase._setFAQList');
    try {
      return super._setFAQList(data);
    } finally {
      _$_FAQStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic nextPage() {
    final _$actionInfo = _$_FAQStoreBaseActionController.startAction(
        name: '_FAQStoreBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_FAQStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic previousPage() {
    final _$actionInfo = _$_FAQStoreBaseActionController.startAction(
        name: '_FAQStoreBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_FAQStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userRole: ${userRole},
faqModel: ${faqModel},
pageablePage: ${pageablePage},
faqEditModel: ${faqEditModel},
searchFAQ: ${searchFAQ},
pageController: ${pageController},
currentPage: ${currentPage}
    ''';
  }
}
