// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_email_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChangeEmailStore on _ChangeEmailStoreBase, Store {
  final _$emailAtom = Atom(name: '_ChangeEmailStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$onInitAsyncAction = AsyncAction('_ChangeEmailStoreBase.onInit');

  @override
  Future<void> onInit() {
    return _$onInitAsyncAction.run(() => super.onInit());
  }

  final _$_ChangeEmailStoreBaseActionController =
      ActionController(name: '_ChangeEmailStoreBase');

  @override
  void reset() {
    final _$actionInfo = _$_ChangeEmailStoreBaseActionController.startAction(
        name: '_ChangeEmailStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_ChangeEmailStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email}
    ''';
  }
}
