import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/checklist_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/question_model.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:mobx/mobx.dart';
part 'checklist_store.g.dart';

class ChecklistStore = _ChecklistStoreBase with _$ChecklistStore;

abstract class _ChecklistStoreBase with Store {
  final ISellerDatasource _datasource = serviceLocator<ISellerDatasource>();

  @observable
  ChecklistModel? checklistModel;
  @action
  _setChecklistModel(ChecklistModel newData) {
    checklistModel = newData;
  }

  Future<bool> startChecklist(String sellerId) async {
    try {
      var ret = await _datasource.startChecklistBySellerId(sellerId: sellerId);

      print(ret);

      _setChecklistModel(ret);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> answerChecklist(List<QuestionsModel> listChecklist) async {
    try {
      ChecklistModel checklist = ChecklistModel(
        id: checklistModel!.id,
        dataVisita: DateTime.now(),
        // questions: listChecklist,
      );

      _datasource.answerChecklist(
        checklistModel: checklist,
        listChecklist: listChecklist,
      );

      return true;
    } catch (err) {
      return false;
    }
  }
}
