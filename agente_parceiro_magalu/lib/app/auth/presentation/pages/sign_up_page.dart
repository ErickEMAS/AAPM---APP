import 'package:agente_parceiro_magalu/app/auth/presentation/stores/sign_up_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/formatter_helper.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
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
  void dispose() {
    _store.reset();
    super.dispose();
  }

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
          validator: _store.validateCpf,
          inputFormatters: [
            CpfCnpjInputMask(),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool formOk = _store.formKey.currentState!.validate();
                  if (!formOk) return;

                  bool ret = await LoadingOverlay.of(context).during(
                    _store.verifyCpf(),
                  );

                  if (ret) {
                    _store.nextPage();
                  } else {
                    SnackBarHelper.snackBar(context,
                        message: "CPF não autenticado");
                  }
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
    return Observer(builder: (_) {
      return Column(
        children: [
          ..._formColumn(
            controller: _store.emailController,
            validator: _store.validateEmail,
            hint: "Digite seu e-mail",
            label: "E-mail",
          ),
          ..._formColumn(
            controller: _store.nomeController,
            validator: _store.validateSignUpField,
            hint: "Digite seu nome completo",
            label: "Nome",
          ),
          ..._formColumn(
            controller: _store.apelidoController,
            validator: _store.validateSignUpField,
            hint: "Digite seu apelido",
            label: "Apelido",
          ),
          ..._formColumn(
            controller: _store.passwordController,
            isPassword: true,
            isObscure: _store.isObscure,
            onTapSulfixIcon: _store.passwordVisibilityToggle,
            validator: _store.validatePassword,
            hint: "Digite sua senha",
            label: "Senha",
          ),
          ..._formColumn(
            controller: _store.passwordConfirmController,
            isPassword: true,
            isObscure: _store.isObscureConfirm,
            onTapSulfixIcon: _store.passwordConfirmVisibilityToggle,
            validator: _store.validateConfirmPassword,
            hint: "Confirme sua senha",
            label: "Confirmação da senha",
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool formOk = _store.formKey.currentState!.validate();
                    if (!formOk) return;

                    bool ret = await LoadingOverlay.of(context).during(
                      _store.onSignUpSubmitted(),
                    );

                    if (ret) {
                      SnackBarHelper.snackBar(context,
                          message:
                              "Usuario ${_store.userModel.roles.first}, cadastrado com sucesso!");
                      _store.navigateToDashboard(context);
                    } else {
                      SnackBarHelper.snackBar(context,
                          message: "Algo inesperado aconteceu");
                    }
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
    });
  }

  _formColumn({
    required String hint,
    required String label,
    bool isPassword = false,
    bool isObscure = false,
    Function? onTapSulfixIcon,
    String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return [
      TextFormField(
        obscureText: isObscure,
        controller: controller,
        validator: validator,
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
