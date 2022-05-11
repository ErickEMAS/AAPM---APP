// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TagStore on _TagStoreBase, Store {
  final _$selectedColorAtom = Atom(name: '_TagStoreBase.selectedColor');

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

  final _$tagSelectedIdAtom = Atom(name: '_TagStoreBase.tagSelectedId');

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

  final _$_TagStoreBaseActionController =
      ActionController(name: '_TagStoreBase');

  @override
  dynamic _setTagList(List<TagModel> data) {
    final _$actionInfo = _$_TagStoreBaseActionController.startAction(
        name: '_TagStoreBase._setTagList');
    try {
      return super._setTagList(data);
    } finally {
      _$_TagStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelectedColor(Color newData) {
    final _$actionInfo = _$_TagStoreBaseActionController.startAction(
        name: '_TagStoreBase.setSelectedColor');
    try {
      return super.setSelectedColor(newData);
    } finally {
      _$_TagStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTagNameSelected(String newData) {
    final _$actionInfo = _$_TagStoreBaseActionController.startAction(
        name: '_TagStoreBase.setTagNameSelected');
    try {
      return super.setTagNameSelected(newData);
    } finally {
      _$_TagStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedColor: ${selectedColor},
tagSelectedId: ${tagSelectedId}
    ''';
  }
}
