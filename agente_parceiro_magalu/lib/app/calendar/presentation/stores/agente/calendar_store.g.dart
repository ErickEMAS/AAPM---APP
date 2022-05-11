// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CalendarStore on _CalendarStoreBase, Store {
  final _$searchAtom = Atom(name: '_CalendarStoreBase.search');

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  final _$_CalendarStoreBaseActionController =
      ActionController(name: '_CalendarStoreBase');

  @override
  dynamic _setSellerModelList(List<SellerModel> data) {
    final _$actionInfo = _$_CalendarStoreBaseActionController.startAction(
        name: '_CalendarStoreBase._setSellerModelList');
    try {
      return super._setSellerModelList(data);
    } finally {
      _$_CalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic _setSellerList(List<SellerModel> data) {
    final _$actionInfo = _$_CalendarStoreBaseActionController.startAction(
        name: '_CalendarStoreBase._setSellerList');
    try {
      return super._setSellerList(data);
    } finally {
      _$_CalendarStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search}
    ''';
  }
}
