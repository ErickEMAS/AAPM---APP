import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  String userRole = "";

  @observable
  String currentPage = AppRoutes.home;

  Future<bool> onHomeInit() async {
    try {
      userRole = (await SecureStorageHelper.read(key: StorageKeys.userRole))!;
      return true;
    } catch (err) {
      return false;
    }
  }
}
