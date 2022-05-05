import 'package:mobx/mobx.dart';
part 'seller_fields_store.g.dart';

class SellerFieldsStore = _SellerFieldsStoreBase with _$SellerFieldsStore;

abstract class _SellerFieldsStoreBase with Store {
  @observable
  String def = "";

  @action
  Future<void> fun() async {
  }
}
