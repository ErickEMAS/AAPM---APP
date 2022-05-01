import 'package:agente_parceiro_magalu/core/locators/auth_locators.dart';
import 'package:agente_parceiro_magalu/core/locators/http_locators.dart';
import 'package:agente_parceiro_magalu/core/locators/sellers_locators.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.I;

Future<void> setupLocators() async {
  setupAuthLocators();
  setupSellersLocators();
  setupHttpLocators();
}
