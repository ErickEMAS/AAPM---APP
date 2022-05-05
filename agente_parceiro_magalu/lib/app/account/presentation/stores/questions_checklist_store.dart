import 'package:mobx/mobx.dart';
part 'questions_checklist_store.g.dart';

class QuestionChecklistStore = _QuestionChecklistStoreBase with _$QuestionChecklistStore;

abstract class _QuestionChecklistStoreBase with Store {
  @observable
  String def = "";

  @action
  Future<void> fun() async {
  }
}
