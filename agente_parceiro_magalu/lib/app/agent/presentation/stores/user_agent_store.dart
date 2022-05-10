import 'package:agente_parceiro_magalu/app/agent/data/datasources/agent_datasource.dart';
import 'package:agente_parceiro_magalu/app/agent/data/models/carteira_model.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../../data/models/user_agent_model.dart';

part 'user_agent_store.g.dart';

class UserAgentStore = _UserAgentStoreBase with _$UserAgentStore;

abstract class _UserAgentStoreBase with Store {
  final IAgentDatasource _datasource = serviceLocator<IAgentDatasource>();

  final formKey = GlobalKey<FormState>();

  int pageableSize = 10;

  ObservableList<UserAgentModel> userAgenteModelList =
      ObservableList<UserAgentModel>();

  @observable
  CarteiraModel carteiraModel = CarteiraModel(id: "");

  @observable
  String search = "";

  @observable
  bool searchClicked = true;

  @observable
  String? role = "null";

  @observable
  bool filterUserActive = true;

  @observable
  int pageablePage = 0;

  @observable
  int pageablePageAgent = 0;

  @observable
  PageController pageController = PageController();

  @observable
  int currentPage = 0;

  @observable
  UserAgentModel userAgentselected = UserAgentModel(
    id: "",
    cpf: "",
    roles: [],
    emailConfirmed: false,
    active: false,
    enabled: false,
    totalSeller: 0,
  );

  @action
  Future<bool> onUsersInit() async {
    try {
      PageListModel pageList = await _datasource.getUsers(
        size: pageableSize,
        page: 0,
        role: role,
        active: filterUserActive,
        search: search,
      );

      userAgenteModelList.clear();
      _setUserAgenteModelList(pageList.content.cast<UserAgentModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  @action
  reset() {
    carteiraModel = CarteiraModel(id: "");

    userAgentselected = UserAgentModel(
      id: "",
      cpf: "",
      roles: [],
      emailConfirmed: false,
      active: false,
      enabled: false,
      totalSeller: 0,
    );

    pageController = PageController();

    role = null;
    currentPage = 0;
    pageablePage = 0;
    pageableSize = 10;
    searchClicked = false;
    filterUserActive = false;
    search = "";

    userAgenteModelList.clear();
  }

  @action
  resetmodels() {
    carteiraModel = CarteiraModel(id: "");

    userAgentselected = UserAgentModel(
      id: "",
      cpf: "",
      roles: [],
      emailConfirmed: false,
      active: false,
      enabled: false,
      totalSeller: 0,
    );
  }

  @action
  setSearchClicked(bool newData) {
    searchClicked = newData;
  }

  @action
  setFilterUserActive(bool newData) {
    filterUserActive = newData;
  }

  @action
  setSearch(String newData) {
    search = newData;
  }

  @action
  _setPage(int value) => pageablePage = value;

  @action
  _setUserAgentselected(UserAgentModel newData) {
    userAgentselected = newData;
  }

  @action
  nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    currentPage = 1;
  }

  @action
  previousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
    currentPage = 0;
  }

  @action
  _setUserAgenteModelList(List<UserAgentModel> data) {
    userAgenteModelList.addAll(data);
  }

  Future<bool> fetchNextPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList = await _datasource.getUsers(
        size: pageableSize,
        page: pageablePage,
        role: role,
        active: filterUserActive,
        search: search,
      );

      _setUserAgenteModelList(pageList.content.cast<UserAgentModel>().toList());

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  Future<bool> desactiveUser({required int index}) async {
    try {
      userAgentselected =
          await _datasource.desactiveUser(id: userAgentselected.id);

      userAgenteModelList[index] = userAgentselected;
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> reactiveUser({required int index}) async {
    try {
      userAgentselected =
          await _datasource.reactiveUser(cpf: userAgentselected.cpf);

      userAgenteModelList[index] = userAgentselected;
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> getUserCarteira() async {
    try {
      carteiraModel =
          await _datasource.getCarteira(userId: userAgentselected.id);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> navigateToUserOverview(BuildContext context) {
    return Navigator.of(context).pushNamed(AppRoutes.userAgenteOverview).then(
          (value) => false,
        );
  }

  void navigateback(BuildContext context) {
    return Navigator.pop(context);
  }
}
