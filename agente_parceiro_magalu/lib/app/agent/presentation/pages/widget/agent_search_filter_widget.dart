import 'package:agente_parceiro_magalu/app/agent/presentation/stores/user_agent_store.dart';
import 'package:agente_parceiro_magalu/core/constants/app_dimens.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../../shared/themes/app_colors.dart';
import '../../../../../../shared/themes/app_text_styles.dart';
import '../../../../../../shared/widgets/app_dropdown.dart';

class AgenteSearchFilterWidget extends StatefulWidget {
  const AgenteSearchFilterWidget({Key? key}) : super(key: key);

  @override
  State<AgenteSearchFilterWidget> createState() => AgenteSearchFilterWidgetState();
}

class AgenteSearchFilterWidgetState extends State<AgenteSearchFilterWidget> {
  final UserAgentStore _store = serviceLocator<UserAgentStore>();

  String? dropdownSelection;

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;

    return Observer(builder: (_) {
      return Column(
        children: [
          AppDropdown(
            textHint: _store.role == null ? "Todos" : _store.role! == "ROLE_ADMIN" ? "Administrador" : "Agente" ,
            width: phoneWidth,
            value: dropdownSelection,
            customItems: [
              DropdownMenuItem(
                child: Text(
                  "Administrador",
                  style: AppTextStyles.regular(
                    size: 16,
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _store.role = "ROLE_ADMIN";
                    _store.onUsersInit();
                  });
                },
                value: "Administrador",
              ),
              DropdownMenuItem(
                child: Text(
                  "Agente",
                  style: AppTextStyles.regular(
                    size: 16,
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _store.role = "ROLE_USER";
                    _store.onUsersInit();
                  });
                },
                value: "Agente",
              ),
              DropdownMenuItem(
                child: Text(
                  "Todos",
                  style: AppTextStyles.regular(
                    size: 16,
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _store.role = null;
                    _store.onUsersInit();
                  });
                },
                value: "Todos",
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
