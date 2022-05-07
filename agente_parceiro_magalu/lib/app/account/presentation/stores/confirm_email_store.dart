import 'dart:convert';

import 'package:agente_parceiro_magalu/app/account/data/datasources/account_datasource.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/send_code_model.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/http/exceptions/exceptions.dart';
import '../../../../core/locators/service_locators.dart';
part 'confirm_email_store.g.dart';

class ConfirmEmailStore = _ConfirmEmailStoreBase with _$ConfirmEmailStore;

abstract class _ConfirmEmailStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();
  
  final formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  
  TextEditingController codeController = TextEditingController();
  
  @observable
  String email = "";

  @action
  Future<void> onInit() async {
    var user = jsonDecode((await SecureStorageHelper.read(key: StorageKeys.loggedUser))!);
    email = user["email"];
    print("user");
    print(user);
  }

  @action
  void reset() {
    pageController.initialPage;

    codeController.clear();

    email = "";
  }

  Future<bool> forgotPassWordSendCode() async {
    try {
      await _datasource.sendCode(sendCode: SendCode(email: email, codeType: CodeType.EMAIL_CONFIRM));

      return true;
    } on Unauthorized {
      return false;
    }
  }

  Future<bool> confirmEmail() async {
    try {
      await _datasource.confirmeEmail(email: email, code: codeController.text);

      return true;
    } on Unauthorized {
      return false;
    }
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
