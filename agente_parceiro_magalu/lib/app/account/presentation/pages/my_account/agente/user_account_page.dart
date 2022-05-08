import 'package:agente_parceiro_magalu/core/loading_overlay.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bar_gradient_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_bottom_bar_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_safe_area_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_logout_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_accoun_item_list_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_account_footer_widget.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../../../shared/themes/app_colors.dart';
import '../../../stores/my_account/agente/user_account_store.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  State<UserAccountPage> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  final UserAccountStore _store = UserAccountStore();

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
                            name: _store.userName,
                            role: "Agente",
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
                            tittle: "Minhas Tags",
                            iconData: Icons.bookmarks,
                            onClick: () => _store.navigateToMyTags(context),
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
