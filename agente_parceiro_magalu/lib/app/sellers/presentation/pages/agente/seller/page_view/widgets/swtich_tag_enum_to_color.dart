import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';

class SwitchTagEnum {
  static switchEnumColor(TagColors color) {
    switch (color) {
      case TagColors.amarelo:
        return AppColors.amarelo;
      case TagColors.azul:
        return AppColors.azul;
      case TagColors.verde:
        return AppColors.verde;
      case TagColors.laranja:
        return AppColors.laranja;
      case TagColors.rosa:
        return AppColors.rosa;
      case TagColors.roxo:
        return AppColors.roxo;
      default:
        AppColors.primary;
    }
  }
}
