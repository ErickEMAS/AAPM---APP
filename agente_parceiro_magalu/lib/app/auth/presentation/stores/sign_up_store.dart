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

  final TextEditingController cpfController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late final UserModel userModel;

  SignUpModel formSignUp = SignUpModel(
    id: "",
    email: "",
    cpf: "",
    fullName: "",
    password: "",
    passwordConfirm: "",
  );

  @observable
  bool isObscure = true;

  @observable
  bool isObscureConfirm = true;

  @observable
  String fullName = "";

  @observable
  String email = "";

  String id = "";

  @action
  void reset() {
    pageController.initialPage;
    codeController.clear();
    cpfController.clear();

    userModel = UserModel(
      id: "",
      cpf: "",
      emailIsConfirmed: false,
      roles: [],
    );

    formSignUp = SignUpModel(
      id: "",
      email: "",
      cpf: "",
      fullName: "",
      password: "",
      passwordConfirm: "",
    );

    isObscureConfirm = true;
    isObscure = true;
    fullName = "";
    email = "";
    id = "";
  }

  @action
  void setDefault(UserModel user) {
    fullName = userModel.fullName ?? "";
    email = userModel.email ?? "";
    id = userModel.id;
    cpfController.text = userModel.cpf;
  }

  Future<bool> verifyCpf() async {
    try {
      userModel = await _authUseCase.verifyCpf(cpf: cpfController.text);

      setDefault(userModel);

      return true;
    } on Unauthorized {
      return false;
    }
  }

  Future<bool> onSignUpSubmitted() async {
    try {
      SignUpModel signUpModel = SignUpModel(
        id: id,
        email: email,
        cpf: cpfController.text.replaceAll(".", "").replaceAll("-", ""),
        fullName: fullName,
        password: formSignUp.password,
        passwordConfirm: formSignUp.passwordConfirm,
      );

      await _authUseCase.signUp(signUpModel: signUpModel);

      return true;
    } on Unauthorized {
      return false;
    } catch (err) {
      print(err);
      throw false;
    }
  }

  Future<bool> confirmEmail() async {
    try {
      await _authUseCase.confirmeEmail(email: email, code: codeController.text);

      return true;
    } on Unauthorized {
      return false;
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
    if (password != password)
      return "A confirmaçao de senha não é igual a senha";

    return null;
  }

  Future<bool> navigateToDashboard(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.dashboard)
        .then((value) => true);
  }
}
