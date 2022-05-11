import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/http/exceptions/exceptions.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../auth/data/models/send_code_model.dart';
import '../../data/datasources/account_datasource.dart';
part 'change_email_store.g.dart';

class ChangeEmailStore = _ChangeEmailStoreBase with _$ChangeEmailStore;

abstract class _ChangeEmailStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();
  
  final formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();
  
  TextEditingController codeController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  
  @observable
  String email = "";

  @action
  Future<void> onInit() async {
    var user = jsonDecode((await SecureStorageHelper.read(key: StorageKeys.loggedUser))!);
    email = user["email"];
  }

  @action
  void reset() {
    pageController.initialPage;

    codeController.clear();
    newEmailController.clear();

    email = "";
  }

  Future<bool> changeEmail() async {
    try {
      await _datasource.changeEmail(newEmail: newEmailController.text, code: codeController.text);

      return true;
    } on Unauthorized {
      return false;
    }
  }

  Future<bool> changeEmailSendCode() async {
    try {
      await _datasource.sendCode(sendCode: SendCode(email: email, codeType: CodeType.EMAIL_CHANGE));

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
