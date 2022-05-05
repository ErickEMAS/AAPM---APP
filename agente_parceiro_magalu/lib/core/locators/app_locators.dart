import 'package:agente_parceiro_magalu/app/home/presentation/stores/home_store.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

Future<void> setupAppLocators() async {
  //home
  serviceLocator.registerLazySingleton<HomeStore>(
    () => HomeStore(),
  );
}
