import 'package:agente_parceiro_magalu/app/auth/domain/usecases/auth_usecases.dart';
import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'forgot_password_store.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final IAuthUseCase _authUseCase = serviceLocator<IAuthUseCase>();
  final ForgotPassWordStore _forgotPasswordStore =
      serviceLocator<ForgotPassWordStore>();

//adm login
  // TextEditingController emailController =
  //     TextEditingController(text: 'admin@apm.com.br');
  //user login
  TextEditingController emailController =
      TextEditingController(text: 'testesdaluacoding@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'Teste!23');

  final formKey = GlobalKey<FormState>();

  bool _unauthorized = false;

  @observable
  bool isObscure = true;

  @action
  passwordVisibilityToggle() {
    isObscure = !isObscure;
  }

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

  Future<bool> navigateToHome(BuildContext context) async {
    String? role = await SecureStorageHelper.read(key: StorageKeys.userRole);

    return Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      ModalRoute.withName(AppRoutes.login),
      arguments: role,
    ).then((value) => false);
  }

  Future<bool> navigateToForgotPassword(BuildContext context) {
    _forgotPasswordStore.emailController = emailController;
    return Navigator.of(context)
        .pushNamed(AppRoutes.forgotPassword)
        .then((value) => true);
  }

  String? validateEmailPassword(String? text) {
    if (text == "") return "Campo não pode ser vazio";
    if (_unauthorized) return "Erro";
    return null;
  }
}
