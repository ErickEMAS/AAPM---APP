// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_checklist_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuestionChecklistStore on _QuestionChecklistStoreBase, Store {
  final _$defAtom = Atom(name: '_QuestionChecklistStoreBase.def');

  @override
  String get def {
    _$defAtom.reportRead();
    return super.def;
  }

  @override
  set def(String value) {
    _$defAtom.reportWrite(value, super.def, () {
      super.def = value;
    });
  }

  final _$funAsyncAction = AsyncAction('_QuestionChecklistStoreBase.fun');

  @override
  Future<void> fun() {
    return _$funAsyncAction.run(() => super.fun());
  }

  @override
  String toString() {
    return '''
def: ${def}
    ''';
  }
}
