import 'package:agente_parceiro_magalu/app/auth/data/datasource/auth_datasource.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthDatasource _datasource = AuthDatasource();

  TextEditingController emailController =
      TextEditingController(text: 'emas.erk@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'lumos123456');

  Future<bool> login() async {
    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty)
        return false;

      await _datasource.login(
          email: emailController.text, password: passwordController.text);

      return true;
    } catch (err) {
      print(err);
      throw false;
    }
  }

  Future<bool> navigateToHome(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.home)
        .then((value) => true);
  }
}
