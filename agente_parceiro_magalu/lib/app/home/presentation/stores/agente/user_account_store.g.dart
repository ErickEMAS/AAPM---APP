// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserAccountStore on _UserAccountStoreBase, Store {
  final _$userNameAtom = Atom(name: '_UserAccountStoreBase.userName');

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  final _$emailConfirmedAtom =
      Atom(name: '_UserAccountStoreBase.emailConfirmed');

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

  final _$onInitAsyncAction = AsyncAction('_UserAccountStoreBase.onInit');

  @override
  Future<void> onInit() {
    return _$onInitAsyncAction.run(() => super.onInit());
  }

  @override
  String toString() {
    return '''
userName: ${userName},
emailConfirmed: ${emailConfirmed}
    ''';
  }
}
