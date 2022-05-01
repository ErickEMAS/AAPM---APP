import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';

import '../stores/forgot_password_store.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ForgotPassWordStore _store = serviceLocator<ForgotPassWordStore>();

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);

    if (route != null) {
      List<String>? path = ModalRoute.of(context)?.settings.name?.split("/");
      print("path");
      print(path![1]);

      print(route);
      print(route.settings);
      print(route.settings.name);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarGradient(
        title: "Recuperar senha",
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
              _emailFormView(),
              _codeFormView(),
              _changePasswordFormView(),
              _passwordRedefined(),
            ],
          ),
        ),
      ),
    );
  }

  _emailFormView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: _store.emailController,
          validator: _store.validateEmail,
          decoration: const InputDecoration(
            hintText: "Digite seu email",
            labelText: "Email",
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Um código será enviado ao e-mail cadastrado",
        ),
        const SizedBox(height: 150),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              bool formOk = _store.formKey.currentState!.validate();

              bool ret = await LoadingOverlay.of(context).during(
                _store.forgotPassWordSendCode(),
              );

              if (ret) {
                _store.nextPage();
              } else {
                SnackBarHelper.snackBar(
                  context,
                  isError: true,
                  message: "Falha ao solicitar redefinição de senha",
                );
              }

              if (!formOk) return;
            },
            child: const Text("Enviar código"),
          ),
        ),
      ],
    );
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
          "Informe o código recebido por e-mail",
        ),
        const SizedBox(height: 150),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              bool formOk = _store.formKey.currentState!.validate();

              bool ret = await LoadingOverlay.of(context).during(
                _store.forgotPassWordConfirmCode(),
              );

              print(ret);

              if (ret) {
                _store.nextPage();
              } else {
                SnackBarHelper.snackBar(
                  context,
                  isError: true,
                  message: "Falha ao solicitar redefinição de senha",
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

  _changePasswordFormView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: _store.passwordController,
          validator: _store.validatePassword,
          decoration: const InputDecoration(
            hintText: "Digite sua nova senha",
            labelText: "Senha",
          ),
        ),
        SizedBox(height: AppDimens.space),
        TextFormField(
          controller: _store.passwordConfirmController,
          validator: _store.validatePassword,
          decoration: const InputDecoration(
            hintText: "Confirme sua nova senha",
            labelText: "Confirmar Senha",
          ),
        ),
        const SizedBox(height: 160),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              bool formOk = _store.formKey.currentState!.validate();

              bool ret = await LoadingOverlay.of(context).during(
                _store.forgotPassWordChangePassword(),
              );

              if (ret) {
                _store.nextPage();
              } else {
                SnackBarHelper.snackBar(
                  context,
                  isError: true,
                  message: "Falha ao solicitar redefinição de senha",
                );
              }

              if (!formOk) return;
            },
            child: const Text("Redefinir senha"),
          ),
        ),
      ],
    );
  }

  _passwordRedefined() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Senha redefinida com sucesso"),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _store.navigateback(context);
            },
            child: const Text("Entrar"),
          ),
        ),
      ],
    );
  }
}
