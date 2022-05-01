// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpStore on _SignUpStoreBase, Store {
  final _$isObscureAtom = Atom(name: '_SignUpStoreBase.isObscure');

  @override
  bool get isObscure {
    _$isObscureAtom.reportRead();
    return super.isObscure;
  }

  @override
  set isObscure(bool value) {
    _$isObscureAtom.reportWrite(value, super.isObscure, () {
      super.isObscure = value;
    });
  }

  final _$isObscureConfirmAtom =
      Atom(name: '_SignUpStoreBase.isObscureConfirm');

  @override
  bool get isObscureConfirm {
    _$isObscureConfirmAtom.reportRead();
    return super.isObscureConfirm;
  }

  @override
  set isObscureConfirm(bool value) {
    _$isObscureConfirmAtom.reportWrite(value, super.isObscureConfirm, () {
      super.isObscureConfirm = value;
    });
  }

  final _$_SignUpStoreBaseActionController =
      ActionController(name: '_SignUpStoreBase');

  @override
  void reset() {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic passwordVisibilityToggle() {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.passwordVisibilityToggle');
    try {
      return super.passwordVisibilityToggle();
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic passwordConfirmVisibilityToggle() {
    final _$actionInfo = _$_SignUpStoreBaseActionController.startAction(
        name: '_SignUpStoreBase.passwordConfirmVisibilityToggle');
    try {
      return super.passwordConfirmVisibilityToggle();
    } finally {
      _$_SignUpStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isObscure: ${isObscure},
isObscureConfirm: ${isObscureConfirm}
    ''';
  }
}
