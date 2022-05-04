import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  final List<String>? list;
  final List<DropdownMenuItem>? customItems;
  final dynamic value;
  final String textHint;
  final bool isDisable;
  final String? disableHint;
  final IconData iconAsIconData;
  final String iconAsImage;
  final double width;
  final Function(dynamic)? onChange;

  AppDropdown({
    Key? key,
    this.list,
    required this.onChange,
    this.value,
    this.textHint = "",
    this.isDisable = false,
    this.disableHint,
    this.customItems,
    this.iconAsIconData = Icons.arrow_drop_down,
    this.iconAsImage = "",
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      decoration: BoxDecoration(),
      child: DropdownButton(
        value: value,
        disabledHint: isDisable ? Text(disableHint ?? "") : null,
        dropdownColor: const Color(0xFFF1F3F5),
        elevation: 4,
        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12)),
        underline: Container(),
        isExpanded: true,
        hint: Text(
          textHint == "" ? "Selecione" : textHint,
        ),
        items: customItems ??
            list!.map((String itemsValue) {
              return DropdownMenuItem(
                value: itemsValue,
                child: Text(itemsValue),
              );
            }).toList(),
        onChanged: isDisable ? null : onChange,
      ),
    );
  }
}
