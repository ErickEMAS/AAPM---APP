import 'package:agente_parceiro_magalu/app/account/presentation/stores/add_admin_store.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/helpers/formatter_helper.dart';
import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';
import '../../../../../core/snackbar_helper.dart';

class AddAdminPage extends StatefulWidget {
  const AddAdminPage({Key? key}) : super(key: key);

  @override
  State<AddAdminPage> createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  final AddAdminStore _store = serviceLocator<AddAdminStore>();

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
          title: "Cadastrar Agente",
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
                    _infoForm(),
                    _adminRegistered(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _infoForm() {
    return Observer(builder: (_) {
      return Column(
        children: [
          TextFormField(
            controller: _store.cpfController,
            decoration: const InputDecoration(
              hintText: "Digite seu CPF",
              labelText: "CPF*",
            ),
            validator: _store.validateCpf,
            inputFormatters: [
              CpfCnpjInputMask(),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _store.nomeController,
            decoration: const InputDecoration(
              hintText: "Digite o nome completo do novo admin",
              labelText: "Nome Completo",
            ),
          ),
          SizedBox(height: AppDimens.space),
          TextFormField(
            controller: _store.emailController,
            validator: (text) => _store.validateEmail(text),
            decoration: const InputDecoration(
              hintText: "Digite o email do novo admin",
              labelText: "Email",
            ),
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
                      _store.signUpAdmin(),
                    );

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
          const SizedBox(height: 10),
          const Text(
            "*Campo Obrigatório",
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      );
    });
  }

  _adminRegistered() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Adminstrador Cadastrado com sucesso",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 16),
        Text("CPF: " + _store.cpfController.text),
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
