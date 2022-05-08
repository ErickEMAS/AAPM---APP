import 'package:agente_parceiro_magalu/app/account/data/models/alternative_model.dart';
import 'package:agente_parceiro_magalu/app/account/data/models/dynamic_field_model.dart';
import 'package:agente_parceiro_magalu/core/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../../../../core/routes/app_routes.dart';
import '../../data/datasources/account_datasource.dart';
import '../../data/models/dynamic_question_checkList_model.dart';
part 'questions_checklist_store.g.dart';

class QuestionChecklistStore = _QuestionChecklistStoreBase
    with _$QuestionChecklistStore;

abstract class _QuestionChecklistStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();

  final formKey = GlobalKey<FormState>();

  bool update = false;

  int pageableSize = 10;

  TextEditingController newAlternativeController = TextEditingController();

  ObservableList<DynamicQuestionCheckListModel> questionList = ObservableList<DynamicQuestionCheckListModel>();

  @observable
  DynamicQuestionCheckListModel dynamicQuestionCheckListModel =
      DynamicQuestionCheckListModel(
    question: "",
    alternatives: [],
    active: true,
    fieldUpdate: DynamicFieldModel(name: "", type: TypeField.TEXT),
  );

  @observable
  String status = "";

  @observable
  bool searchClicked = false;

  @observable
  int pageablePage = 0;

  @observable
  PageController pageController = PageController();

  @observable
  int currentPage = 0;

  @observable
  DynamicQuestionCheckListModel dynamicQuestionCheckListEditModel =
      DynamicQuestionCheckListModel(
    question: "",
    alternatives: [],
    fieldUpdate: DynamicFieldModel(name: "", type: TypeField.TEXT),
  );

  @action
  Future<bool> onQuestionsInit() async {
    try {
      PageListModel pageList = await _datasource.getDynamicQuestionCheckLists(
        size: pageableSize,
        page: pageablePage,
        status: status,
      );

      questionList.clear();
      _setDynamicQuestionCheckListEditModelList(
          pageList.content.cast<DynamicQuestionCheckListModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  @action
  reset() {
    dynamicQuestionCheckListModel = DynamicQuestionCheckListModel(
      question: "",
      alternatives: [],
      active: true,
      fieldUpdate: DynamicFieldModel(name: "", type: TypeField.TEXT),
    );

    dynamicQuestionCheckListEditModel = DynamicQuestionCheckListModel(
      question: "",
      alternatives: [],
      fieldUpdate: DynamicFieldModel(name: "", type: TypeField.TEXT),
    );

    pageController = PageController();

    status = "";
    currentPage = 0;
    pageablePage = 0;
    pageableSize = 10;
    searchClicked = false;
    update = false;

    questionList.clear();
    newAlternativeController.clear();
  }

  @action
  resetmodels() {
    dynamicQuestionCheckListModel = DynamicQuestionCheckListModel(
      question: "",
      alternatives: [],
      active: true,
      fieldUpdate: DynamicFieldModel(name: "", type: TypeField.TEXT),
    );

    dynamicQuestionCheckListEditModel = DynamicQuestionCheckListModel(
      question: "",
      alternatives: [],
      fieldUpdate: DynamicFieldModel(name: "", type: TypeField.TEXT),
    );
  }

  @action
  setSearchClicked(bool newData) {
    searchClicked = newData;
  }

  @action
  _setPage(int value) => pageablePage = value;

  @action
  _setDynamicQuestionCheckListEditModel(DynamicQuestionCheckListModel newData) {
    dynamicQuestionCheckListEditModel = newData;
  }

  @action
  addNewAlternative() {
    AlternativeModel newAlternativeModel =
        AlternativeModel(name: newAlternativeController.text, checked: false);
    dynamicQuestionCheckListModel.alternatives.add(newAlternativeModel);
    dynamicQuestionCheckListEditModel.alternatives.add(newAlternativeModel);
    newAlternativeController.clear();
  }

  @action
  removeAlternative({required AlternativeModel alternativeModel}) {
    dynamicQuestionCheckListModel.alternatives.remove(alternativeModel);
    dynamicQuestionCheckListEditModel.alternatives.remove(alternativeModel);
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
    onQuestionsInit();
  }

  @action
  setStatus(String newData) {
    status = newData;
  }

  @action
  _setDynamicQuestionCheckListEditModelList(
      List<DynamicQuestionCheckListModel> data) {
    questionList.addAll(data);
  }

  Future<bool> fetchNextPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList = await _datasource.getDynamicQuestionCheckLists(
        size: pageableSize,
        page: pageablePage,
        status: status,
      );

      _setDynamicQuestionCheckListEditModelList(
          pageList.content.cast<DynamicQuestionCheckListModel>().toList());

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  Future<bool> addDynamicQuestion() async {
    try {
      await _datasource.addDynamicQuestionCheckList(
          dynamicQuestionCheckListModel: dynamicQuestionCheckListModel);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateDynamicQuestion() async {
    try {
      await _datasource.updateDynamicQuestionCheckList(
          dynamicQuestionCheckListModel: dynamicQuestionCheckListEditModel);

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
}
