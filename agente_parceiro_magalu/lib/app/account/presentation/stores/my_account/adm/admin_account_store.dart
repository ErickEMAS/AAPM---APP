import 'dart:convert';

import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/constants/storage_keys.dart';
import '../../../../../../core/helpers/storage_helper.dart';
part 'admin_account_store.g.dart';

class AdminAccountStore = _AdminAccountStoreBase with _$AdminAccountStore;

abstract class _AdminAccountStoreBase with Store {
  @observable
  String adminName = "";

  @observable
  bool emailConfirmed = true;

  @action
  Future<void> onInit() async {
    var admin = jsonDecode((await SecureStorageHelper.read(key: StorageKeys.loggedUser))!);
    adminName = admin["fullName"];
    emailConfirmed = admin["emailIsConfirmed"];
  }

  Future<bool> navigateToConfirmEmail(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.confirmEmail)
        .then((value) => true);
  }

  Future<bool> navigateToChangepassword(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.changepassword)
        .then((value) => true);
  }

  Future<bool> navigateToChangeEmail(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.changeEmail)
        .then((value) => true);
  }

  Future<bool> navigateToAddagente(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.addagente)
        .then((value) => true);
  }

  Future<bool> navigateToAddAdmin(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.addAdmin)
        .then((value) => true);
  }

  Future<bool> navigateToSellerFields(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.sellerFields)
        .then((value) => true);
  }

  Future<bool> navigateToQuestionsChecklist(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.questionsChecklist)
        .then((value) => true);
  }
}
