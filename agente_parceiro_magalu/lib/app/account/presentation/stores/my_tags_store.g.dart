// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tags_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MyTagsStore on _MyTagsStoreBase, Store {
  final _$pageControllerAtom = Atom(name: '_MyTagsStoreBase.pageController');

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

  final _$selectedColorAtom = Atom(name: '_MyTagsStoreBase.selectedColor');

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

  final _$onTagInitAsyncAction = AsyncAction('_MyTagsStoreBase.onTagInit');

  @override
  Future<bool> onTagInit() {
    return _$onTagInitAsyncAction.run(() => super.onTagInit());
  }

  final _$_MyTagsStoreBaseActionController =
      ActionController(name: '_MyTagsStoreBase');

  @override
  dynamic setSelectedColor(Color newData) {
    final _$actionInfo = _$_MyTagsStoreBaseActionController.startAction(
        name: '_MyTagsStoreBase.setSelectedColor');
    try {
      return super.setSelectedColor(newData);
    } finally {
      _$_MyTagsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setTagList(List<TagModel> data) {
    final _$actionInfo = _$_MyTagsStoreBaseActionController.startAction(
        name: '_MyTagsStoreBase._setTagList');
    try {
      return super._setTagList(data);
    } finally {
      _$_MyTagsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic reset() {
    final _$actionInfo = _$_MyTagsStoreBaseActionController.startAction(
        name: '_MyTagsStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_MyTagsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageController: ${pageController},
selectedColor: ${selectedColor}
    ''';
  }
}
