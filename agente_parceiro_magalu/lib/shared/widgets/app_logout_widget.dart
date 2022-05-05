import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';

class AppLogout extends StatelessWidget {

  const AppLogout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => logout(context: context),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        height: 60,
        width: double.infinity,
        color: AppColors.white,
        child: Row(
          children: const [
            SizedBox(width: 16),
            Icon(
              Icons.logout,
              color: AppColors.vermelho,
              size: 24,
            ),
            SizedBox(width: 16),
            Text(
              "Logout",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.vermelho,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> logout({required BuildContext context}) async {
    await SecureStorageHelper.write(key: StorageKeys.token, value: "");
    await SecureStorageHelper.write(key: StorageKeys.userRole, value: "");
    await SecureStorageHelper.write(key: StorageKeys.loggedUser, value: "");
    Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.dashboard,
        ModalRoute.withName(AppRoutes.dashboard),
      ).then((value) => false);
  }
