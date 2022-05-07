import 'dart:convert';

import 'package:agente_parceiro_magalu/app/auth/data/models/change_password_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/http/exceptions/exceptions.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../auth/data/models/send_code_model.dart';
import '../../data/datasources/account_datasource.dart';
part 'change_password_store.g.dart';

class ChangePasswordStore = _ChangePasswordStoreBase with _$ChangePasswordStore;

abstract class _ChangePasswordStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();
  
  final formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  
  @observable
  String email = "";

  bool _unauthorized = false;

  @action
  Future<void> onInit() async {
    var user = jsonDecode((await SecureStorageHelper.read(key: StorageKeys.loggedUser))!);
    email = user["email"];
  }

  @action
  void reset() {
    pageController.initialPage;

    codeController.clear();
    passwordController.clear();
    passwordConfirmController.clear();

    email = "";
    _unauthorized = false;
  }

  Future<bool> changePassWordConfirmCode() async {
    try {
      await _datasource.confirmeCodeChangePassword(email: email, code: codeController.text);

      return true;
    } on Unauthorized {
      _unauthorized = true;
      return false;
    }
  }

  Future<bool> changePassword() async {
    try {
      await _datasource.changePassword(changePassword: ChangePassword(email: email, code: codeController.text, password: passwordController.text, passwordConfirm: passwordConfirmController.text));

      return true;
    } on Unauthorized {
      _unauthorized = true;
      return false;
    }
  }

  Future<bool> changePassWordSendCode() async {
    try {
      await _datasource.sendCode(sendCode: SendCode(email: email, codeType: CodeType.PASSWORD_CHANGE));

      return true;
    } on Unauthorized {
      _unauthorized = true;
      return false;
    }
  }

  String? validatePassword(String? text) {
    if (text == "") return "Campo não pode ser vazio";
    if (_unauthorized) return "Erro";
    return null;
  }

  void navigateback(BuildContext context) {
    return Navigator.pop(context);
  }

  nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 900),
      curve: Curves.ease,
    );
  }
}
