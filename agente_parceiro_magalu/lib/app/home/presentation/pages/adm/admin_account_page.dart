import 'package:agente_parceiro_magalu/app/home/presentation/stores/adm/admin_account_store.dart';
import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_logout_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_accoun_item_listt_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_account_footer_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AdminAccountPage extends StatefulWidget {
  const AdminAccountPage({Key? key}) : super(key: key);

  @override
  State<AdminAccountPage> createState() => _AdminAccountPageState();
}

class _AdminAccountPageState extends State<AdminAccountPage> {
  final AdminAccountStore _store = AdminAccountStore();

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
        bottomNavigationBar: AppBottomBar(),
        appBar: const AppBarGradient(
          title: "Minha conta",
        ),
        body: Observer(
          builder: (_) {
            return ListView(
              children: [
                AppUserInfo(
                  name: _store.adminName,
                  role: "Administrador",
                  emailConfirmed: _store.emailConfirmed,
                ),
                AppUserAccountItemList(
                  tittle: "Trocar senha",
                  iconData: Icons.lock,
                  onClick: () => print("Trocar senha"),
                ),
                AppUserAccountItemList(
                  tittle: "Alterar E-mail",
                  iconData: Icons.mail,
                  onClick: () => print("Alterar E-mail"),
                ),
                AppUserAccountItemList(
                  tittle: "Minhas Tags",
                  iconData: Icons.bookmarks,
                  onClick: () => print("Minhas Tags"),
                ),
                AppLogout(),
                AppUserAccountFooter(),
              ],
            );
          },
        ),
      ),
    );
  }
}
