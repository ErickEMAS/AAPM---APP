import 'package:flutter/material.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';

class AppUserInfo extends StatelessWidget {
  String name;
  String role;
  bool emailConfirmed;

  AppUserInfo(
      {Key? key,
      required this.name,
      required this.role,
      required this.emailConfirmed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("Atualizar Dados"),
      child: Container(
        height: 80,
        width: double.infinity,
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 16),
                CircleAvatar(
                  child: Text(
                    name != null ? name[0] : "",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w200,
                      color: AppColors.white,
                    ),
                  ),
                  backgroundColor: AppColors.primary,
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.darkGrey,
                        ),
                      ),
                      Text(
                        role,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            emailConfirmed
                ? Container()
                : GestureDetector(
                  onTap: () => print("Confirmar e-mail"),
                  child: Container(
                    height: 80,
                    child: Row(
                        children: const [
                          Text(
                            "Conrifmar E-mail",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.vermelho,
                            ),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
