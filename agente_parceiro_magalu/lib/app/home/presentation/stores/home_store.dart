import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  @observable
  String userRole = "";

  @observable
  bool admin = false;

  @observable
  String currentPage = AppRoutes.home;

  Future<bool> onHomeInit() async {
    try {
      userRole = (await SecureStorageHelper.read(key: StorageKeys.userRole))!;
      admin = userRole == "ROLE_ADMIN";
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> navigateTocarteirasWithoutOwner(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.carteitaWithoutOwner)
        .then((value) => true);
  }

  Future<bool> navigateToQuestionsChecklist(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.questionsChecklist)
        .then((value) => true);
  }

  Future<bool> navigateToSellerFields(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.sellerFields)
        .then((value) => true);
  }

  Future<bool> navigateToAddagente(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.addagente)
        .then((value) => true);
  }

  Future<bool> navigateToMyTags(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.myTags)
        .then((value) => true);
  }

  Future<bool> navigateToFAQ(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.faq)
        .then((value) => true);
  }

  Future<bool> navigateToHunting(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.hunting)
        .then((value) => true);
  }

  Future<bool> navigateToSellers(BuildContext context) {
    currentPage = AppRoutes.sellers;
    return Navigator.of(context)
        .pushNamedAndRemoveUntil(
          AppRoutes.sellers,
          ModalRoute.withName('/'),
        )
        .then(
          (value) => false,
        );
  }
}
