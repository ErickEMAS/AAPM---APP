import 'package:agente_parceiro_magalu/app/home/presentation/stores/home_store.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final HomeStore _store = serviceLocator<HomeStore>();

  bool isAdmin = false;
  String? path;

  @override
  void initState() {
    isAdmin = _store.userRole == "ROLE_ADMIN";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          bottomIcon(
            tittle: "Home",
            iconData: Icons.home,
            active: _store.currentPage == AppRoutes.home,
            onPressed: () {
              _store.currentPage = AppRoutes.home;
              _navigator(context: context, route: AppRoutes.home);
            },
          ),
          isAdmin
              ? bottomIcon(
                  tittle: "Agentes",
                  iconData: Icons.people,
                  active: _store.currentPage == AppRoutes.agent,
                  onPressed: () {
                    _store.currentPage = AppRoutes.agent;
                    _navigator(context: context, route: AppRoutes.agent);
                  },
                )
              : Container(),
          bottomIcon(
            tittle: "Agenda",
            iconData: Icons.calendar_today,
            active: _store.currentPage == AppRoutes.calendar,
            onPressed: () {
              _store.currentPage = AppRoutes.calendar;
              _navigator(context: context, route: AppRoutes.calendar);
            },
          ),
          bottomIcon(
            tittle: "Carteira",
            iconData: Icons.credit_card,
            active: _store.currentPage == AppRoutes.sellers,
            onPressed: () {
              _store.currentPage = AppRoutes.sellers;
              _navigator(context: context, route: AppRoutes.sellers);
            },
          ),
          bottomIcon(
            tittle: "Minha Conta",
            iconData: isAdmin ? Icons.admin_panel_settings : Icons.person,
            active: _store.currentPage == AppRoutes.userAccount ||
                path == AppRoutes.adminAccount,
            onPressed: () {
              _store.currentPage =
                  isAdmin ? AppRoutes.adminAccount : AppRoutes.userAccount;
              _navigator(
                context: context,
                route: isAdmin ? AppRoutes.adminAccount : AppRoutes.userAccount,
              );
            },
          ),
        ],
      ),
    );
  }

  _navigator({required BuildContext context, required String route}) {
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(
          route,
          ModalRoute.withName('/'),
          arguments: _store.userRole,
        )
        .then(
          (value) => false,
        );
  }
}

bottomIcon({
  required String tittle,
  required IconData iconData,
  required bool active,
  required void Function()? onPressed,
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
            onPressed: onPressed,
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
