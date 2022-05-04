import 'package:flutter/material.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';

class AppUserAccountItemList extends StatelessWidget {
  String tittle;
  IconData iconData;
  void Function() onClick;

  AppUserAccountItemList(
      {Key? key,
      required this.tittle,
      required this.iconData,
      required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        height: 60,
        width: double.infinity,
        color: AppColors.white,
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              iconData,
              color: AppColors.darkGrey,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              tittle,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
