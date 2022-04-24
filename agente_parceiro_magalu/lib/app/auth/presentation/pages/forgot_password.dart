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
              const Text(
                  "Um código será enviado ao e-mail cadastrado",
              ),
              const SizedBox(height: 160),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    bool formOk = _store.formKey.currentState!.validate();

                    bool ret = await LoadingOverlay.of(context).during(
                      _store.ForgotPassWordSendCode(),
                    );

                    if (ret) {
                      _store.navigateToHome(context);
                    } else {
                      SnackBarHelper.snackBar(context,
                          message: "Falha na autentificação");
                    }

                    if (!formOk) return;
                  },
                  child: const Text("Enviar código"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
