import 'package:agente_parceiro_magalu/app/auth/data/datasource/auth_datasource.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/usecases/auth_usecases.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'sign_up_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  final IAuthUseCase _authUseCase = serviceLocator<IAuthUseCase>();

  final PageController pageController = PageController();

  final formKey = GlobalKey<FormState>();

  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController apelidoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @observable
  bool isObscure = true;
  @observable
  bool isObscureConfirm = true;

  Future<bool> verifyCpf() async {
    try {
      var cpf = cpfController.text.replaceAll(".", "").replaceAll("-", "");
      await _authUseCase.verifyCpf(cpf: cpf);

      return true;
    } on Unauthorized {
      return false;
    }
  }

  onSignUpSubmitted() {
    try {
      SignUpModel formSignUp = SignUpModel(
        cpf: cpfController.text,
        email: emailController.text,
        fullName: nomeController.text,
        nickName: apelidoController.text,
        password: passwordController.text,
        passwordConfirm: passwordConfirmController.text,
      );

      print(formSignUp.fullName);

      _authUseCase.signUp(signUpModel: formSignUp);
    } catch (err) {}
  }

  @action
  passwordVisibilityToggle() {
    isObscure = !isObscure;
  }

  @action
  passwordConfirmVisibilityToggle() {
    isObscureConfirm = !isObscureConfirm;
  }

  nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 900),
      curve: Curves.ease,
    );
  }
}
