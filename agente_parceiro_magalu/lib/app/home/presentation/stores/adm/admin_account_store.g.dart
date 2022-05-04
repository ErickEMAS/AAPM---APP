// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdminAccountStore on _AdminAccountStoreBase, Store {
  final _$adminNameAtom = Atom(name: '_AdminAccountStoreBase.adminName');

  @override
  String get adminName {
    _$adminNameAtom.reportRead();
    return super.adminName;
  }

  @override
  set adminName(String value) {
    _$adminNameAtom.reportWrite(value, super.adminName, () {
      super.adminName = value;
    });
  }

  final _$emailConfirmedAtom =
      Atom(name: '_AdminAccountStoreBase.emailConfirmed');

  @override
  bool get emailConfirmed {
    _$emailConfirmedAtom.reportRead();
    return super.emailConfirmed;
  }

  @override
  set emailConfirmed(bool value) {
    _$emailConfirmedAtom.reportWrite(value, super.emailConfirmed, () {
      super.emailConfirmed = value;
    });
  }

  final _$onInitAsyncAction = AsyncAction('_AdminAccountStoreBase.onInit');

  @override
  Future<void> onInit() {
    return _$onInitAsyncAction.run(() => super.onInit());
  }

  @override
  String toString() {
    return '''
adminName: ${adminName},
emailConfirmed: ${emailConfirmed}
    ''';
  }
}
