import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'my_tags_store.g.dart';

class MyTagsStore = _MyTagsStoreBase with _$MyTagsStore;

abstract class _MyTagsStoreBase with Store {
  int pageableSize = 15;
  int pageablePage = 0;

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
