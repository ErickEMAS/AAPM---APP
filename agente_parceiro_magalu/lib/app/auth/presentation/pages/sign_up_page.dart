import 'package:agente_parceiro_magalu/app/auth/presentation/stores/sign_up_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpStore _store = serviceLocator<SignUpStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarGradient(
        title: "Cadastro",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Form(
          key: _store.formKey,
          child: PageView(
            controller: _store.pageController,
            children: [
              _cpfFormView(),
              _infoForm(),
            ],
          ),
        ),
      ),
    );
  }

  _cpfFormView() {
    return Column(
      children: [
        TextFormField(
          controller: _store.cpfController,
          decoration: const InputDecoration(
            hintText: "Digite seu CPF",
            labelText: "CPF",
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // _store.verifyCpf();

                  _store.nextPage();
                },
                child: const Text("Próximo"),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }

  _infoForm() {
    return Column(
      children: [
        ..._formColumn(
          controller: _store.emailController,
          hint: "Digite seu e-mail",
          label: "E-mail",
        ),
        ..._formColumn(
          controller: _store.nomeController,
          hint: "Digite seu nome completo",
          label: "Nome",
        ),
        ..._formColumn(
          controller: _store.apelidoController,
          hint: "Digite seu apelido",
          label: "Apelido",
        ),
        ..._formColumn(
          controller: _store.passwordController,
          isPassword: true,
          isObscure: _store.isObscure,
          onTapSulfixIcon: _store.passwordVisibilityToggle(),
          hint: "Digite sua senha",
          label: "Senha",
        ),
        ..._formColumn(
          controller: _store.passwordConfirmController,
          isPassword: true,
          isObscure: _store.isObscureConfirm,
          onTapSulfixIcon: _store.passwordConfirmVisibilityToggle(),
          hint: "Confirme sua senha",
          label: "Confirmação da senha",
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // _store.nextPage();
                  _store.onSignUpSubmitted();
                },
                child: const Text("Cadastrar"),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }

  _formColumn({
    required String hint,
    required String label,
    bool isPassword = false,
    bool isObscure = false,
    Function? onTapSulfixIcon,
    required TextEditingController controller,
  }) {
    return [
      TextFormField(
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          suffixIcon: isPassword
              ? isObscure
                  ? IconButton(
                      icon: const Icon(
                        Icons.visibility_off,
                      ),
                      onPressed: onTapSulfixIcon != null
                          ? () => onTapSulfixIcon()
                          : () {},
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.visibility,
                      ),
                      onPressed: onTapSulfixIcon != null
                          ? () => onTapSulfixIcon()
                          : () {},
                    )
              : null,
        ),
      ),
      SizedBox(height: AppDimens.space),
    ];
  }
}
