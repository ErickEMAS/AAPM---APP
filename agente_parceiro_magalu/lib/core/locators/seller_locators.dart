import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/checklist_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_sheet_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/seller_store.dart';
import 'package:agente_parceiro_magalu/app/sellers/presentation/stores/agente/tag_store.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

Future<void> setupSellerLocators() async {
  serviceLocator.registerLazySingleton<ISellerDatasource>(
    () => SellerDatasource(),
  );
  serviceLocator.registerLazySingleton<SellerStore>(
    () => SellerStore(),
  );
  serviceLocator.registerLazySingleton<SellerSheetStore>(
    () => SellerSheetStore(),
  );
  serviceLocator.registerLazySingleton<ChecklistStore>(
    () => ChecklistStore(),
  );
  serviceLocator.registerLazySingleton<TagStore>(
    () => TagStore(),
  );
}
