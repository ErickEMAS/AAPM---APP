import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  Future<bool> navigateToHome(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.home)
        .then((value) => true);
  }
}
