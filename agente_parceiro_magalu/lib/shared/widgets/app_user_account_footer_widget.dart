import 'package:flutter/material.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';

class AppUserAccountFooter extends StatelessWidget {
  const AppUserAccountFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 16),
            Text(
              "Equipe Lumos"
              "\nLeticia Silva Ferraz Melo"
              "\nErick Alexandre Mendes de Souza"
              "\nApp Agente Parceiro Magalo - versão 1.00.0",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
