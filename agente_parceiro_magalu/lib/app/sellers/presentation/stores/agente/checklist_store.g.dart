// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChecklistStore on _ChecklistStoreBase, Store {
  final _$checklistModelAtom = Atom(name: '_ChecklistStoreBase.checklistModel');

  @override
  ChecklistModel? get checklistModel {
    _$checklistModelAtom.reportRead();
    return super.checklistModel;
  }

  @override
  set checklistModel(ChecklistModel? value) {
    _$checklistModelAtom.reportWrite(value, super.checklistModel, () {
      super.checklistModel = value;
    });
  }

  final _$_ChecklistStoreBaseActionController =
      ActionController(name: '_ChecklistStoreBase');

  @override
  dynamic _setChecklistModel(ChecklistModel newData) {
    final _$actionInfo = _$_ChecklistStoreBaseActionController.startAction(
        name: '_ChecklistStoreBase._setChecklistModel');
    try {
      return super._setChecklistModel(newData);
    } finally {
      _$_ChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setChecklistList(List<ChecklistModel> data) {
    final _$actionInfo = _$_ChecklistStoreBaseActionController.startAction(
        name: '_ChecklistStoreBase._setChecklistList');
    try {
      return super._setChecklistList(data);
    } finally {
      _$_ChecklistStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
checklistModel: ${checklistModel}
    ''';
  }
}
