import 'package:agente_parceiro_magalu/app/auth/presentation/stores/login_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/snackbar_helper.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginStore _store = serviceLocator<LoginStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const AppBarGradient(
        title: "Login",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Observer(builder: (_) {
          return Form(
            key: _store.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _store.emailController,
                  validator: _store.validateEmailPassword,
                  decoration: const InputDecoration(
                    hintText: "Digite seu email",
                    labelText: "Email",
                  ),
                ),
                SizedBox(height: AppDimens.space),
                TextFormField(
                  obscureText: _store.isObscure,
                  controller: _store.passwordController,
                  validator: _store.validateEmailPassword,
                  decoration: InputDecoration(
                      hintText: "Digite sua senha",
                      labelText: "Senha",
                      suffixIcon: _store.isObscure
                          ? IconButton(
                              icon: const Icon(
                                Icons.visibility_off,
                              ),
                              onPressed: () {
                                _store.passwordVisibilityToggle();
                              },
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.visibility,
                              ),
                              onPressed: () {
                                _store.passwordVisibilityToggle();
                              },
                            )),
                ),
                const SizedBox(height: 160),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      bool formOk = _store.formKey.currentState!.validate();

                      bool ret = await LoadingOverlay.of(context).during(
                        _store.login(),
                      );

                      if (ret) {
                        _store.navigateToHome(context);
                      } else {
                        SnackBarHelper.snackBar(
                          context,
                          isError: true,
                          message: "Falha na autentificação",
                        );
                      }

                      if (!formOk) return;
                    },
                    child: const Text("Entrar"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _store.navigateToForgotPassword(context);
                  },
                  child: const Text(
                    "Esqueci minha senha",
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
