import 'package:agente_parceiro_magalu/app/agent/data/datasources/agent_datasource.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/driveactivity/v2.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../agent/data/models/carteira_model.dart';
import '../../../agent/data/models/user_agent_model.dart';
import '../../data/datasources/account_datasource.dart';
part 'carteiras_without_owner_store.g.dart';

class CarteirasWithOwnerStore = _CarteirasWithOwnerStoreBase
    with _$CarteirasWithOwnerStore;

abstract class _CarteirasWithOwnerStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();
  final IAgentDatasource _datasourceAgent = serviceLocator<IAgentDatasource>();

  final formKey = GlobalKey<FormState>();

  bool update = false;

  int pageableSize = 10;

  TextEditingController newAlternativeController = TextEditingController();

  ObservableList<CarteiraModel> carteiraList = ObservableList<CarteiraModel>();

  @observable
  CarteiraModel carteiraSelected = CarteiraModel(id: "");

  @observable
  UserAgentModel agentModel = UserAgentModel(
    id: "",
    cpf: "",
    roles: [],
    totalSeller: 0,
  );

  @observable
  int pageablePage = 0;
  
  @observable
  int pageablePageAgent = 0;

  @observable
  PageController pageController = PageController();

  @observable
  int currentPage = 0;

  @action
  Future<bool> onQuestionsInit() async {
    try {
      PageListModel pageList = await _datasource.getCarteiras(
        size: pageableSize,
        page: 0,
      );

      carteiraList.clear();
      _setcarteiraList(pageList.content.cast<CarteiraModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> getUsers() async {
    try {
      PageListModel pageList = await _datasourceAgent.getUsers(
        size: 10,
        page: 0,
        role: "ROLE_USER",
        active: true,
        search: "",
      );

      userAgenteModelList.clear();
      _setUserAgenteModelList(pageList.content.cast<UserAgentModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> fetchNextAgentPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList = await _datasourceAgent.getUsers(
        size: 10,
        page: pageablePage,
        role: "ROLE_USER",
        active: true,
        search: "",
      );

      _setUserAgenteModelList(pageList.content.cast<UserAgentModel>().toList());

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  ObservableList<UserAgentModel> userAgenteModelList = ObservableList<UserAgentModel>();

  @observable
  bool searchClicked = false;

  @observable
  String? search;

  @action
  setSearch(String? newData) {
    search = newData;
  }

  @action
  setSearchClicked(bool newData) {
    searchClicked = newData;
  }

  @action
  _setUserAgenteModelList(List<UserAgentModel> data) {
    userAgenteModelList.addAll(data);
  }

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
  reset() {
    carteiraSelected = CarteiraModel(id: "");

    pageController = PageController();

    currentPage = 0;
    pageablePage = 0;
    pageableSize = 10;
    update = false;

    carteiraList.clear();
    newAlternativeController.clear();
  }

  @action
  _setPage(int value) => pageablePage = value;

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
    onQuestionsInit();
  }

  @action
  _setcarteiraList(List<CarteiraModel> data) {
    carteiraList.addAll(data);
  }

  Future<bool> fetchNextPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList = await _datasource.getCarteiras(
        size: pageableSize,
        page: pageablePage,
      );

      _setcarteiraList(pageList.content.cast<CarteiraModel>().toList());

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  Future<bool> transferCarteira() async {
    try {
      await _datasource.transferCarteira(
          carteiraId: carteiraSelected.id, userId: userAgentselected.id);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> navigateToEditSeller(BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.editSeller, arguments: sellerId)
        .then(
          (value) => false,
        );
  }

  Future<bool> navigateToChecklistVisita(
      BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.checklistVisitaSeller, arguments: sellerId)
        .then(
          (value) => false,
        );
  }

  Future<bool> navigateToSellerOverview(BuildContext context, String sellerId) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.sellerOverview, arguments: sellerId)
        .then(
          (value) => false,
        );
  }
  
  Future<bool> navigateToAgentListForCarteiraView(BuildContext context) {
    return Navigator.of(context)
        .pushNamed(AppRoutes.agentListForCarteira)
        .then(
          (value) => false,
        );
  }

  void navigateback(BuildContext context) {
    return Navigator.pop(context);
  }
}
