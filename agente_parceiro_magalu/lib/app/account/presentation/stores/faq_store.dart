import 'package:mobx/mobx.dart';
part 'faq_store.g.dart';

class FAQStore = _FAQStoreBase with _$FAQStore;

abstract class _FAQStoreBase with Store {
  @observable
  String def = "";

  @action
  Future<void> fun() async {
  }
}
