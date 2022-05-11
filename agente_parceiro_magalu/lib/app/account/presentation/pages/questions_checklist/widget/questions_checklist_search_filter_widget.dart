import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../core/constants/enums.dart';
import '../../../../../../shared/themes/app_colors.dart';
import '../../../../../../shared/themes/app_text_styles.dart';
import '../../../../../../shared/widgets/app_dropdown.dart';
import '../../../stores/questions_checklist_store.dart';

class QuestionsChecklistSearchFilterWidget extends StatefulWidget {
  const QuestionsChecklistSearchFilterWidget({Key? key}) : super(key: key);

  @override
  State<QuestionsChecklistSearchFilterWidget> createState() =>
      _FAQSearchFilterWidgetState();
}

class _FAQSearchFilterWidgetState
    extends State<QuestionsChecklistSearchFilterWidget> {
  final QuestionChecklistStore _store =
      serviceLocator<QuestionChecklistStore>();

  String? dropdownSelection;
  TextEditingController nomeSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Observer(builder: (_) {
      return Column(
        children: [
          AppDropdown(
            textHint: _store.status,
            width: phoneWidth,
            value: dropdownSelection,
            customItems: [
              DropdownMenuItem(
                child: Text(
                  "ativado",
                  style: AppTextStyles.regular(
                    size: 16,
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _store.status = "ativado";
                    _store.onQuestionsInit();
                  });
                },
                value: "ativado",
              ),
              DropdownMenuItem(
                child: Text(
                  "desativado",
                  style: AppTextStyles.regular(
                    size: 16,
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _store.status = "desativado";
                    _store.onQuestionsInit();
                  });
                },
                value: "desativado",
              ),
              DropdownMenuItem(
                child: Text(
                  "todos",
                  style: AppTextStyles.regular(
                    size: 16,
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _store.status = "todos";
                    _store.onQuestionsInit();
                  });
                },
                value: "todos",
              ),
            ],
            onChange: (value) {
              setState(() {});
            },
          ),
          SizedBox(height: AppDimens.space),
        ],
      );
    });
  }
}
