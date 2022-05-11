import 'package:agente_parceiro_magalu/app/account/presentation/stores/change_password_store.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';
import '../../../../../core/snackbar_helper.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ChangePasswordStore _store = serviceLocator<ChangePasswordStore>();

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
          title: "Trocar Senha",
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
                    _changePasswordFormView(),
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
                _store.changePassWordSendCode(),
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
                _store.changePassWordConfirmCode(),
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
                _store.changePassword(),
              );

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
            child: const Text("Redefinir senha"),
          ),
        ),
      ],
    );
  }
}
