import 'package:agente_parceiro_magalu/core/constants/enums.dart';

class UFbuilder {
  static List<String> uf() {
    List<String> ufListTitle = [];

    for (var uf in UF.values) {
      ufListTitle.add(uf.name.toString().toUpperCase());
    }

    return ufListTitle;
  }
}
