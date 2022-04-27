import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? path = ModalRoute.of(context)?.settings.name?.split("/")[1];
    print(path);

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
              Navigator.of(context)
                  .pushNamed(AppRoutes.home)
                  .then((value) => true);
            },
          ),
          iconBottomApp(
            tittle: "Carteira",
            iconData: Icons.store,
            active: path == "sellers",
            nav: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.sellers)
                  .then((value) => true);
            },
          ),
          iconBottomApp(
            tittle: "Agenda",
            iconData: Icons.calendar_today,
            active: path == "calendar",
            nav: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.calendar)
                  .then((value) => true);
            },
          ),
          iconBottomApp(
            tittle: "Minha Conta",
            iconData: Icons.person,
            active: path == "account",
            nav: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.account)
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
