import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

class AppBottomBar extends StatelessWidget {
  final String role;
  const AppBottomBar({
    Key? key,
    required this.role,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String? path = ModalRoute.of(context)?.settings.name?.split("/")[1];
    bool admin = role == "ROLE_ADMIN";

    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iconBottomApp(
            tittle: "Home",
            iconData: Icons.home,
            active: path == "home",
            nav: () {
              Navigator.pushNamed(context, AppRoutes.home, arguments: role)
                  .then((value) => true);
            },
          ),
          admin ? iconBottomApp(
            tittle: "Agentes",
            iconData: Icons.person,
            active: path == "agent",
            nav: () {
              Navigator.pushNamed(context, AppRoutes.agent, arguments: role)
                  .then((value) => true);
            },
          ) : Container(),
          iconBottomApp(
            tittle: "Carteira",
            iconData: Icons.store,
            active: path == "sellers",
            nav: () {
              Navigator.pushNamed(context, AppRoutes.sellers, arguments: role)
                  .then((value) => true);
            },
          ),
          iconBottomApp(
            tittle: "Agenda",
            iconData: Icons.calendar_today,
            active: path == "calendar",
            nav: () {
              Navigator.pushNamed(context, AppRoutes.calendar, arguments: role)
                  .then((value) => true);
            },
          ),
          iconBottomApp(
            tittle: "Minha Conta",
            iconData: Icons.person,
            active: path == "userAccount" || path == "adminAccount",
            nav: () {
              Navigator.pushNamed(context, admin ? AppRoutes.adminAccount : AppRoutes.userAccount, arguments: role)
                  .then((value) => true);
            },
          ),
        ],
      ),
    );
  }
}

iconBottomApp({
  required String tittle,
  required IconData iconData,
  required bool active,
  required Function nav,
}) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              width: 6, color: active ? AppColors.primary : Colors.transparent),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              iconData,
              color: active ? AppColors.primary : AppColors.inputHint,
              size: 24,
            ),
            onPressed: () {
              nav();
            },
          ),
          Text(tittle,
              style: TextStyle(
                fontSize: 12,
                color: active ? AppColors.primary : AppColors.inputHint,
              )),
        ],
      ),
    ),
  );
}
