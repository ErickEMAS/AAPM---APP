import 'dart:convert';

import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/constants/storage_keys.dart';
import '../../../../../../core/helpers/storage_helper.dart';
import '../../../auth/data/models/user_model.dart';
part 'user_detail_store.g.dart';

class UserDatailStore = _UserDatailStoreBase with _$UserDatailStore;

abstract class _UserDatailStoreBase with Store {
  @observable
  UserModel user = UserModel(id: "", cpf: "", emailConfirmed: true, roles: []);

  @action
  Future<void> onInit() async {
    var userStorage = jsonDecode((await SecureStorageHelper.read(key: StorageKeys.loggedUser))!);
    user = UserModel.fromJson(userStorage);
  }

  Future<bool> navigateToConfirmEmail(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.confirmEmail)
        .then((value) => true);
  }
}
