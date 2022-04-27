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
          bottomIcon(
            tittle: "Home",
            iconData: Icons.home,
            active: path == AppRoutes.home.replaceAll("/", ""),
            nav: () {
              _navigator(context: context, route: AppRoutes.home);
            },
          ),
          admin
              ? bottomIcon(
                  tittle: "Agentes",
                  iconData: Icons.people,
                  active: path == AppRoutes.agent.replaceAll("/", ""),
                  nav: () {
                    _navigator(context: context, route: AppRoutes.agent);
                  },
                )
              : Container(),
          bottomIcon(
            tittle: "Carteira",
            iconData: Icons.credit_card,
            active: path == AppRoutes.sellers.replaceAll("/", ""),
            nav: () {
              _navigator(context: context, route: AppRoutes.sellers);
            },
          ),
          bottomIcon(
            tittle: "Agenda",
            iconData: Icons.calendar_today,
            active: path == AppRoutes.calendar.replaceAll("/", ""),
            nav: () {
              _navigator(context: context, route: AppRoutes.calendar);
            },
          ),
          bottomIcon(
            tittle: "Minha Conta",
            iconData: admin ? Icons.admin_panel_settings : Icons.person,
            active: path == AppRoutes.userAccount.replaceAll("/", "") ||
                path == AppRoutes.adminAccount.replaceAll("/", ""),
            nav: () {
              _navigator(
                context: context,
                route: admin ? AppRoutes.adminAccount : AppRoutes.userAccount,
              );
            },
          ),
        ],
      ),
    );
  }

  _navigator({required BuildContext context, required String route}) {
    if (ModalRoute.of(context)?.settings.name?.split("/")[1] ==
        route.replaceAll("/", "")) {
      return null;
    } else {
      return Navigator.of(context)
          .pushNamedAndRemoveUntil(
            route,
            ModalRoute.withName('/'),
            arguments: role,
          )
          .then(
            (value) => false,
          );
    }
  }
}

bottomIcon({
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
