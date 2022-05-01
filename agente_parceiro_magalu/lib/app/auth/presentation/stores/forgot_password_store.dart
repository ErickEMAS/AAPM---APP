import 'package:agente_parceiro_magalu/app/auth/domain/usecases/auth_usecases.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/change_password_model.dart';
part 'forgot_password_store.g.dart';

class ForgotPassWordStore = _ForgotPassWordStoreBase with _$ForgotPassWordStore;

abstract class _ForgotPassWordStoreBase with Store {
  final IAuthUseCase _authUseCase = serviceLocator<IAuthUseCase>();

  final PageController pageController = PageController();

  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _unauthorized = false;

  Future<bool> forgotPassWordSendCode() async {
    try {
      await _authUseCase.forgotPassWordSendCode(email: emailController.text);

      return true;
    } on Unauthorized {
      _unauthorized = true;
      return false;
    }
  }

  Future<bool> forgotPassWordConfirmCode() async {
    try {
      await _authUseCase.forgotPassWordConfirmeCode(
          email: emailController.text, code: codeController.text);

      return true;
    } on Unauthorized {
      _unauthorized = true;
      return false;
    }
  }

  Future<bool> forgotPassWordChangePassword() async {
    ChangePassword changepassword = ChangePassword(
      email: emailController.text,
      code: codeController.text,
      password: passwordController.text,
      passwordConfirm: passwordConfirmController.text,
    );

    try {
      await _authUseCase.forgotPassWordChangePassword(
          changePassword: changepassword);

      return true;
    } on Unauthorized {
      _unauthorized = true;
      return false;
    }
  }

  void navigateback(BuildContext context) {
    return Navigator.pop(context);
  }

  String? validateEmail(String? text) {
    if (text == "") return "Campo não pode ser vazio";
    if (_unauthorized) return "Erro";
    return null;
  }

  String? validatePassword(String? text) {
    if (text == "") return "Campo não pode ser vazio";
    if (_unauthorized) return "Erro";
    return null;
  }

  nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 900),
      curve: Curves.ease,
    );
  }
}
