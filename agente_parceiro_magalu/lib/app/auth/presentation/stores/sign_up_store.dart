import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/app/auth/domain/usecases/auth_usecases.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'sign_up_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  final IAuthUseCase _authUseCase = serviceLocator<IAuthUseCase>();

  final PageController pageController = PageController();

  final formKey = GlobalKey<FormState>();

  late final UserModel userModel;

  SignUpModel formSignUp = SignUpModel(
    email: '',
    cpf: '',
    fullName: '',
    nickName: '',
    password: '',
    passwordConfirm: '',
  );

  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController apelidoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @observable
  bool isObscure = true;
  @observable
  bool isObscureConfirm = true;

  @action
  void reset() {
    pageController.initialPage;

    UserModel(id: "", cpf: '', emailIsConfirmed: false, roles: []);

    cpfController.clear();
    nomeController.clear();
    apelidoController.clear();
    passwordController.clear();
    passwordConfirmController.clear();

    isObscure = true;
    isObscureConfirm = true;
  }

  Future<bool> verifyCpf() async {
    try {
      userModel = await _authUseCase.verifyCpf(cpf: cpfController.text);

      emailController.text = userModel.email ?? "";
      nomeController.text = userModel.fullName ?? "";
      apelidoController.text = userModel.nickName ?? "";

      return true;
    } on Unauthorized {
      return false;
    }
  }

  Future<bool> onSignUpSubmitted() async {
    try {
      formSignUp.id = userModel.id;
      formSignUp.cpf = userModel.cpf;

      await _authUseCase.signUp(signUpModel: formSignUp);

      return true;
    } on Unauthorized {
      return false;
    } catch (err) {
      print(err);
      throw false;
    }
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

  String? validateEmail(String? text) {
    if (text == "") return "Campo não pode ser vazio";
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(text!)) return 'E-mail não é valido';
    return null;
  }

  String? validateCpf(String? cpf) {
    if (cpf == "") return "Campo não pode ser vazio";
    if (cpf!.length < 11) return "Precisa ter 11 números";

    return null;
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) return "Campo não pode ser vazio";
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Precisa ter pelo menos uma letra maiuscula";
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "Precisa ter pelo menos um número";
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Precisa ter pelo menos um caracter especial";
    }
    if (password.length < 5) {
      return "Precisa ter mais que 3 caracteres";
    }

    return null;
  }

  String? validateConfirmPassword(String? password) {
    if (password!.isEmpty) return "Campo não pode ser vazio";
    if (password != passwordController.text)
      return "A confirmaçao de senha não é igual a senha";

    return null;
  }

  Future<bool> navigateToDashboard(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.dashboard)
        .then((value) => true);
  }
}
