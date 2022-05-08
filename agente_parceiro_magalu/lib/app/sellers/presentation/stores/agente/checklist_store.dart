import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/checklist_model.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
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
      ChecklistModel startCheck =
          await _datasource.startChecklistBySellerId(sellerId: sellerId);

      print(startCheck);

      _setChecklistModel(startCheck);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> answerChecklist() async {
    try {
      checklistModel!.dataVisita = DateTime.now();

      await _datasource.answerChecklist(
        checklistModel: checklistModel!,
      );

      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> getChecklistHistorico(String sellerId) async {
    try {
      await _datasource.getChecklistHistorico(sellerId: sellerId);

      return true;
    } catch (err) {
      return false;
    }
  }
}
