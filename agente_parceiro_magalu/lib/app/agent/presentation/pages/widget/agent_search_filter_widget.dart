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
  State<AgenteSearchFilterWidget> createState() =>
      AgenteSearchFilterWidgetState();
}

class AgenteSearchFilterWidgetState extends State<AgenteSearchFilterWidget> {
  final UserAgentStore _store = serviceLocator<UserAgentStore>();

  String? dropdownSelection;
  TextEditingController searchController = TextEditingController();

  List<bool> isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;
    isSelected = [_store.filterUserActive, !_store.filterUserActive];

    return Observer(builder: (_) {
      return Column(
        children: [
          TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: "Pesquisar",
              hintText: "Pesquisar do seller",
            ),
            onChanged: (value) {
              _store.setSearch(value);
              _store.onUsersInit();
            },
          ),
          SizedBox(height: AppDimens.space * 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _filterUserType(phoneWidth),
              _filterActiveInactive(),
            ],
          ),
        ],
      );
    });
  }

  Column _filterActiveInactive() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ToggleButtons(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text("Ativos"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text("Inativos"),
            ),
          ],
          onPressed: (int index) {
            setState(
              () {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
                if (isSelected[0]) {
                  _store.filterUserActive = true;
                  _store.onUsersInit();
                } else {
                  _store.filterUserActive = false;
                  _store.onUsersInit();
                }
              },
            );
          },
          isSelected: isSelected,
          color: AppColors.black,
          selectedColor: AppColors.primary,
          borderColor: AppColors.grey,
          selectedBorderColor: AppColors.black,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ],
    );
  }

  AppDropdown _filterUserType(double phoneWidth) {
    return AppDropdown(
      textHint: _store.role == null
          ? "Todos"
          : _store.role! == "ROLE_ADMIN"
              ? "Administrador"
              : "Agente",
      width: phoneWidth * .4,
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
    );
  }
}
