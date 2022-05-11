import 'package:agente_parceiro_magalu/app/account/presentation/stores/change_email_store.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';
import '../../../../../core/snackbar_helper.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final ChangeEmailStore _store = serviceLocator<ChangeEmailStore>();

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      LoadingOverlay.of(context).during(_store.onInit());
    });
    super.initState();
  }

  @override
  void dispose() {
    _store.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        bottomNavigationBar: AppBottomBar(),
        appBar: const AppBarGradient(
          title: "Alterar E-mail",
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
                    _newEmailFormView(),
                    _codeFormView(),
                    _emailChanged(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _newEmailFormView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          controller: _store.newEmailController,
          decoration: const InputDecoration(
            hintText: "Digite o novo e-mail",
            labelText: "Novo E-mail",
          ),
        ),
        const SizedBox(height: 10),
        const Text("Um código de verificação será enviado ao e-mail atual.\n"),
        Text("E-mail atual: " + _store.email),
        const SizedBox(height: 150),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              bool formOk = _store.formKey.currentState!.validate();

              bool ret = await LoadingOverlay.of(context).during(
                _store.changeEmailSendCode(),
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
            child: const Text("Solicitar código"),
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
                _store.changeEmail(),
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

  _emailChanged() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "E-mail Alterado com sucesso",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 16),
        Text("E-mail antigo: " + _store.email),
        Text("E-mail Atual: " + _store.newEmailController.text),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _store.navigateback(context);
            },
            child: const Text("Retorna"),
          ),
        ),
      ],
    );
  }
}
