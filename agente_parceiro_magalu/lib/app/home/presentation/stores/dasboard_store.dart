import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
part 'dasboard_store.g.dart';

class DashboardStore = _DashboardStoreBase with _$DashboardStore;

abstract class _DashboardStoreBase with Store {
  Future<bool> navigateToLogin(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(
          AppRoutes.login,
        )
        .then((value) => false);
  }

  Future<bool> navigateToSignUp(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.signUp)
        .then((value) => true);
  }

  Future<void> navigateToHomeIfToken(BuildContext context) async {

    String? token = await SecureStorageHelper.read(key: StorageKeys.token);
    
    if (token !=  null && token !=  "" ) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        ModalRoute.withName(AppRoutes.login),
      ).then((value) => false);
    }
  }
}
