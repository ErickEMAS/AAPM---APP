import 'package:flutter/material.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';

class AppUserDetailItemList extends StatelessWidget {
  String tittle;
  String value;

  AppUserDetailItemList({
    Key? key,
    required this.tittle,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 60,
      width: double.infinity,
      color: AppColors.white,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tittle + ":",
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.azul,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
