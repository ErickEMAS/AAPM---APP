import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_logout_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_accoun_item_list_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_account_footer_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../stores/my_account/adm/admin_account_store.dart';

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
    double height = MediaQuery.of(context).size.height - 144;

    return AppSafeArea(
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        bottomNavigationBar: AppBottomBar(),
        appBar: const AppBarGradient(
          title: "Minha conta",
        ),
        body: Observer(
          builder: (_) {
            return ListView(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: height,
                    maxHeight: double.infinity,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          AppUserInfo(
                            name: _store.adminName,
                            role: "Administrador",
                            emailConfirmed: _store.emailConfirmed,
                          ),
                          AppUserAccountItemList(
                            tittle: "Trocar senha",
                            iconData: Icons.lock,
                            onClick: () =>
                                _store.navigateToChangepassword(context),
                          ),
                          AppUserAccountItemList(
                            tittle: "Alterar E-mail",
                            iconData: Icons.mail,
                            onClick: () =>
                                _store.navigateToChangeEmail(context),
                          ),
                          AppUserAccountItemList(
                            tittle: "Adicionar Agente",
                            iconData: Icons.person_add,
                            onClick: () => _store.navigateToAddagente(context),
                          ),
                          AppUserAccountItemList(
                            tittle: "Adicionar Administrador",
                            iconData: Icons.manage_accounts,
                            onClick: () => _store.navigateToAddAdmin(context),
                          ),
                          AppUserAccountItemList(
                            tittle: "Campos do Seller",
                            iconData: Icons.dashboard_customize,
                            onClick: () =>
                                _store.navigateToSellerFields(context),
                          ),
                          AppUserAccountItemList(
                            tittle: "Questões do Checklist",
                            iconData: Icons.checklist,
                            onClick: () =>
                                _store.navigateToQuestionsChecklist(context),
                          ),
                          AppUserAccountItemList(
                            tittle: "FAQ",
                            iconData: Icons.quiz,
                            onClick: () => _store.navigateToFAQ(context),
                          ),
                          const AppLogout(),
                        ],
                      ),
                      const AppUserAccountFooter(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
