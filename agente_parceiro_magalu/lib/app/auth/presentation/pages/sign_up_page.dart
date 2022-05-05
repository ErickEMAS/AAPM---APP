import 'package:agente_parceiro_magalu/app/auth/presentation/stores/sign_up_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/helpers/formatter_helper.dart';
import 'package:agente_parceiro_magalu/core/helpers/input_validator_helper.dart';
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
              _codeFormView(),
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
                    _store.formSignUp.email = "_store.userModel.email";
                    _store.formSignUp.fullName = "_store.userModel.fullName";
                    _store.nextPage();
                  } else {
                    SnackBarHelper.snackBar(
                      context,
                      isError: true,
                      message: "CPF não autenticado",
                    );
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
            validator: _store.validateEmail,
            hint: "Digite seu e-mail",
            label: "E-mail",
            initialValue: _store.email,
            onChanged: (value) {
              _store.email = value;
            },
          ),
          ..._formColumn(
            validator: InputValidatorHelper.validateCommonField,
            hint: "Digite seu nome completo",
            label: "Nome",
            initialValue: _store.fullName,
            onChanged: (value) {
              _store.fullName = value;
            },
          ),
          ..._formColumn(
            isPassword: true,
            isObscure: _store.isObscure,
            onTapSulfixIcon: _store.passwordVisibilityToggle,
            validator: (value) => _store.validatePassword(value),
            onChanged: (value) {
              _store.formSignUp.password = value;
            },
            hint: "Digite sua senha",
            label: "Senha",
          ),
          ..._formColumn(
            isPassword: true,
            isObscure: _store.isObscureConfirm,
            onTapSulfixIcon: _store.passwordConfirmVisibilityToggle,
            // validator: _store.validateConfirmPassword,
            onChanged: (value) {
              _store.formSignUp.passwordConfirm = value;
            },
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

                    bool ret = await LoadingOverlay.of(context).during(
                      _store.onSignUpSubmitted(),
                    );
                    if (!formOk) return;
                    if (ret) {
                      _store.nextPage();
                    } else {
                      SnackBarHelper.snackBar(
                        context,
                        isError: true,
                        message: "Algo inesperado aconteceu",
                      );
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
    String? initialValue,
    bool isPassword = false,
    bool isObscure = false,
    Function? onTapSulfixIcon,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return [
      TextFormField(
        initialValue: initialValue,
        obscureText: isObscure,
        validator: validator,
        onChanged: onChanged,
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

  _codeFormView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: _store.codeController,
          decoration: const InputDecoration(
            hintText: "Digite o código recebido",
            labelText: "Código",
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Informe o código de confirmação recebido por e-mail",
        ),
        const SizedBox(height: 150),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              bool formOk = _store.formKey.currentState!.validate();

              bool ret = await LoadingOverlay.of(context).during(
                _store.confirmEmail(),
              );

              print(ret);

              if (ret) {
                SnackBarHelper.snackBar(
                  context,
                  message:
                      "E-mail confirmado com sucesso!",
                );
                _store.navigateToDashboard(context);
              } else {
                SnackBarHelper.snackBar(
                  context,
                  isError: true,
                  message: "Falha ao confirmar e-mail",
                );
              }

              if (!formOk) return;
            },
            child: const Text("Confirmar código"),
          ),
        ),
      ],
    );
  }
}
