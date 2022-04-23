import 'package:agente_parceiro_magalu/app/auth/domain/usecases/auth_usecases.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final IAuthUseCase _authUseCase = serviceLocator<IAuthUseCase>();

  TextEditingController emailController =
      TextEditingController(text: 'emas.erk@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'lumos123456');

  final formKey = GlobalKey<FormState>();

  bool _unauthorized = false;

  Future<bool> login() async {
    try {
      await _authUseCase.login(
          email: emailController.text, password: passwordController.text);

      return true;
    } on Unauthorized {
      _unauthorized = true;
      return false;
    }
  }

  Future<bool> navigateToHome(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.home)
        .then((value) => true);
  }

  String? validateEmailPassword(String? text) {
    if (text == "") return "Campo não pode ser vazio";
    if (_unauthorized) return "Erro";
    return null;
  }
}
