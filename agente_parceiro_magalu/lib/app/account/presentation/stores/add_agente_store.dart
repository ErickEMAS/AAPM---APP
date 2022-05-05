import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/http/exceptions/exceptions.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../auth/data/models/sign_up_model.dart';
import '../../data/datasources/account_datasource.dart';
part 'add_agente_store.g.dart';

class AddAgenteStore = _AddAgenteStoreBase with _$AddAgenteStore;

abstract class _AddAgenteStoreBase with Store {
  final IAccountDatasource _authUseCase = serviceLocator<IAccountDatasource>();

  final formKey = GlobalKey<FormState>();
  final PageController pageController = PageController();

  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController cpfController = TextEditingController(text: "");
  final TextEditingController nomeController = TextEditingController(text: "");

  @action
  Future<void> onInit() async {}

  @action
  void reset() {
    pageController.initialPage;

    emailController.clear();
    cpfController.clear();
    nomeController.clear();
  }

  Future<bool> signUpAgente() async {
    try {
      await _authUseCase.signUpAgente(
        signUpModel: SignUpModel(
            email: emailController.text == "" ? null : emailController.text,
            cpf: cpfController.text.replaceAll(".", "").replaceAll("-", ""),
            fullName: nomeController.text == "" ? null : nomeController.text,
            password: null,
            passwordConfirm: null),
      );

      return true;
    } on Unauthorized {
      return false;
    }
  }

  String? validateCpf(String? cpf) {
    if (cpf == "") return "Campo não pode ser vazio";
    if (cpf!.length < 11) return "Precisa ter 11 números";

    return null;
  }

  String? validateEmail(String? text) {
    if (text == "") return null;
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(text!)) return 'E-mail não é valido';
    return null;
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
