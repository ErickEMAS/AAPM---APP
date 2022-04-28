import 'package:agente_parceiro_magalu/app/home/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:mobx/mobx.dart';
part 'seller_store.g.dart';

class SellerStore = _SellerStoreBase with _$SellerStore;

abstract class _SellerStoreBase with Store {
  final ISellerDatasource _datasource = serviceLocator<ISellerDatasource>();

  Future<bool> onSellersInit() async {
    try {
      await _datasource.getSellerByAgenteId();

      return true;
    } catch (err) {
      return false;
    }
  }
}
