import 'package:agente_parceiro_magalu/app/account/presentation/stores/user_detail_store.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_detail_item_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../core/loading_overlay.dart';
import '../../../../../core/locators/service_locators.dart';
import '../../../../../shared/widgets/app_user_info_widget.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final UserDatailStore _store = serviceLocator<UserDatailStore>();

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
        backgroundColor: AppColors.lightGrey,
        bottomNavigationBar: AppBottomBar(),
        appBar: const AppBarGradient(
          title: "Detalhes da conta",
        ),
        body: Observer(
          builder: (_) {
            return ListView(children: [
              Column(
                children: [
                  AppUserInfo(
                    name: _store.user.fullName!,
                    role: "",
                    emailConfirmed: true,
                  ),
                  AppUserDetailItemList(
                    tittle: "E-mail",
                    value: _store.user.email!,
                  ),
                  AppUserDetailItemList(
                    tittle: "Cargo",
                    value: _store.user.roles[0] == "ROLE_ADMIN" ? "Administrador" : "Agente",
                  ),
                  AppUserDetailItemList(
                    tittle: "CPF",
                    value: _store.user.cpf,
                  ),
                ],
              ),
            ]);
          },
        ),
      ),
    );
  }
}
