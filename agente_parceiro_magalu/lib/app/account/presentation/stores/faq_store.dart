import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../../../../core/routes/app_routes.dart';
import '../../data/datasources/account_datasource.dart';
import '../../data/models/faq_model.dart';
part 'faq_store.g.dart';

class FAQStore = _FAQStoreBase with _$FAQStore;

abstract class _FAQStoreBase with Store {
  final IAccountDatasource _datasource = serviceLocator<IAccountDatasource>();

  bool update = false;

  @observable
  String userRole = "";

  @observable
  FAQModel faqModel = FAQModel(
    question: "",
    answer: "",
  );

  @observable
  int pageablePage = 0;

  @action
  _setPage(int value) => pageablePage = value;

  int pageableSize = 10;

  @observable
  FAQModel faqEditModel = FAQModel(
    question: "",
    answer: "",
  );

  @action
  _setFAQEditModel(FAQModel newData) {
    faqEditModel = newData;
  }

  @observable
  String? searchFAQ;

  @action
  reset() {
    faqList.clear();
    searchFAQ = null;
    update = false;

    faqEditModel = FAQModel(
      question: "",
      answer: "",
    );

    faqModel = FAQModel(
      question: "",
      answer: "",
    );
  }

  @action
  setSearchFAQ(String? newData) {
    searchFAQ = newData;
  }

  ObservableList<FAQModel> faqList = ObservableList<FAQModel>();
  @action
  _setFAQList(List<FAQModel> data) {
    faqList.addAll(data);
  }

  Future<bool> onFAQInit() async {
    userRole = (await SecureStorageHelper.read(key: StorageKeys.userRole))!;

    print(userRole);

    try {
      PageListModel pageList = await _datasource.getFAQs(
        size: pageableSize,
        page: 0,
        search: searchFAQ ?? "",
      );

      faqList.clear();
      _setFAQList(pageList.content.cast<FAQModel>().toList());

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> fetchNextPage() async {
    try {
      _setPage(pageablePage + 1);

      PageListModel pageList = await _datasource.getFAQs(
        size: pageableSize,
        page: pageablePage,
        search: searchFAQ ?? "",
      );

      _setFAQList(pageList.content.cast<FAQModel>().toList());

      return true;
    } catch (e) {
      print("Error:  $e");

      return false;
    }
  }

  Future<bool> addFAQ() async {
    try {
      await _datasource.addFAQ(faqModel: faqModel);

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> updateFAQ() async {
    try {
      await _datasource.updateFAQ(faqModel: faqEditModel);

      return true;
    } catch (err) {
      return false;
    }
  }

  //Page view navigation
  final formKey = GlobalKey<FormState>();

  @observable
  PageController pageController = PageController();

  @observable
  int currentPage = 0;

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
}
