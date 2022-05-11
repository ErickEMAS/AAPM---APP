import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:agente_parceiro_magalu/shared/themes/app_colors.dart';

class SwitchTagEnum {
  static switchEnumColor(TagColors color) {
    switch (color) {
      case TagColors.amarelo:
        return AppColors.amareloTag;
      case TagColors.azul:
        return AppColors.azulTag;
      case TagColors.verde:
        return AppColors.verdeTag;
      case TagColors.laranja:
        return AppColors.laranjaTag;
      case TagColors.rosa:
        return AppColors.rosaTag;
      case TagColors.roxo:
        return AppColors.roxoTag;
      default:
        AppColors.primary;
    }
  }
}
