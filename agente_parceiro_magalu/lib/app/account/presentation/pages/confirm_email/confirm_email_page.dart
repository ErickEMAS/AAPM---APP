import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';
import '../../../../../core/snackbar_helper.dart';
import '../../stores/confirm_email_store.dart';

class ConfirmEmailPage extends StatefulWidget {
  const ConfirmEmailPage({Key? key}) : super(key: key);

  @override
  State<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends State<ConfirmEmailPage> {
  final ConfirmEmailStore _store = serviceLocator<ConfirmEmailStore>();

  @override
  void dispose() {
    _store.reset();
    super.dispose();
  }

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onInit());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppBarGradient(
          title: "Recuperar senha",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Observer(
            builder: (_) {
              return Form(
                key: _store.formKey,
                child: PageView(
                  controller: _store.pageController,
                  children: [
                    _emailConfirmeSendCode(),
                    _codeFormView(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _emailConfirmeSendCode() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        const Text("Um código de verificação será enviado ao e-mail:\n"),
        Text(_store.email),
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
                  message: "Falha ao solicitar confirmação de e-mail",
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
                _store.confirmEmail(),
              );

              print(ret);

              if (ret) {
                _store.navigateback(context);
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
}
