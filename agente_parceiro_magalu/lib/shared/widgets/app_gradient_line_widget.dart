import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradientLine extends StatelessWidget {
  const AppGradientLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: const [
            0.1,
            0.2,
            0.3,
            0.4,
            0.5,
            0.6,
            0.7,
            0.9,
          ],
          colors: [
            AppColors.verde,
            AppColors.azulClaro,
            AppColors.azul,
            AppColors.roxo,
            AppColors.rosa,
            AppColors.vermelho,
            AppColors.laranja,
            AppColors.amarelo,
          ],
        ),
      ),
    );
  }
}
