import 'package:agente_parceiro_magalu/app/home/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

Future<void> setupSellersLocators() async {
  serviceLocator.registerLazySingleton<ISellerDatasource>(
    () => SellerDatasource(),
  );
  serviceLocator.registerLazySingleton<SellerStore>(
    () => SellerStore(),
  );
}
