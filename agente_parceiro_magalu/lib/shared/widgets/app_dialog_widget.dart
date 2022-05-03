import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

appDialog({
  required BuildContext context,
  Widget? title,
  TextStyle? titleTextStyle,
  Widget? content,
  List<Widget>? actions,
}) {
  showDialog(
    barrierColor: Color.fromARGB(255, 11, 50, 89).withOpacity(0.3),
    context: context,
    builder: (context) {
      return AlertDialog(
        titlePadding: EdgeInsets.symmetric(horizontal: AppDimens.margin),
        contentPadding: EdgeInsets.only(bottom: AppDimens.margin),
        actionsPadding: EdgeInsets.zero,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        title: title != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  title,
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              )
            : Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: AppColors.primary,
                  ),
                ),
              ),
        content: content,
        actions: actions,
      );
    },
  );
}
