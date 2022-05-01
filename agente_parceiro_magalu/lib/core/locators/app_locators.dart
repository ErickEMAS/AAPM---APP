import 'package:agente_parceiro_magalu/app/home/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/app/home/presentation/stores/home_store.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

Future<void> setupAppLocators() async {
  //sellers
  serviceLocator.registerLazySingleton<ISellerDatasource>(
    () => SellerDatasource(),
  );
  serviceLocator.registerLazySingleton<SellerStore>(
    () => SellerStore(),
  );

  //home
  serviceLocator.registerLazySingleton<HomeStore>(
    () => HomeStore(),
  );
}
