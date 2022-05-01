import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_text_styles.dart';
import 'package:agente_parceiro_magalu/shared/widgets/app_gradient_line_widget.dart';
import 'package:flutter/material.dart';

class AppBarGradient extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool automaticallyImplyLeading;
  const AppBarGradient({
    Key? key,
    this.title,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title != null
              ? Text(
                  title!,
                  style: AppTextStyles.bold(
                    size: 18,
                    color: AppColors.white,
                  ),
                )
              : null,
        ),
        const AppGradientLine(),
      ],
    );
  }
}
