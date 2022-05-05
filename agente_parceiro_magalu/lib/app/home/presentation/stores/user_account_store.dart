import 'dart:convert';

import 'package:mobx/mobx.dart';

import '../../../../../core/constants/storage_keys.dart';
import '../../../../../core/helpers/storage_helper.dart';
part 'user_account_store.g.dart';

class UserAccountStore = _UserAccountStoreBase with _$UserAccountStore;

abstract class _UserAccountStoreBase with Store {
  @observable
  String userName = "";

  @observable
  bool emailConfirmed = true;

  @action
  Future<void> onInit() async {
    var user = jsonDecode(
        (await SecureStorageHelper.read(key: StorageKeys.loggedUser))!);
    userName = user["fullName"];
    emailConfirmed = user["emailIsConfirmed"];
  }
}
