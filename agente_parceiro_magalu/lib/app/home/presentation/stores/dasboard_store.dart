import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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
}
