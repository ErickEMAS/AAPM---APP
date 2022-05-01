// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SellerStore on _SellerStoreBase, Store {
  final _$sellerModelAtom = Atom(name: '_SellerStoreBase.sellerModel');

  @override
  SellerModel get sellerModel {
    _$sellerModelAtom.reportRead();
    return super.sellerModel;
  }

  @override
  set sellerModel(SellerModel value) {
    _$sellerModelAtom.reportWrite(value, super.sellerModel, () {
      super.sellerModel = value;
    });
  }

  @override
  String toString() {
    return '''
sellerModel: ${sellerModel}
    ''';
  }
}
