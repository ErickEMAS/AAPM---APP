import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/api/calendar_api.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:mobx/mobx.dart';

part 'calendar_store.g.dart';

class CalendarStore = _CalendarStoreBase with _$CalendarStore;

abstract class _CalendarStoreBase with Store {
  final ISellerDatasource _sellerDatasource =
      serviceLocator<ISellerDatasource>();

  ObservableList<SellerModel> sellerModelByVisitOrderList =
      ObservableList<SellerModel>();
  @action
  _setSellerModelList(List<SellerModel> data) {
    sellerModelByVisitOrderList.addAll(data);
  }

  ObservableList<SellerModel> sellerList = ObservableList<SellerModel>();
  @action
  _setSellerList(List<SellerModel> data) {
    sellerList.addAll(data);
  }

  List<Event> appointments = [];

  @observable
  int totalElements = 30;

  @observable
  String search = "";
  setSearch(String data) {
    search = data;
  }

  DateTime? date;

  TimeOfDay? horaInicio;
  TimeOfDay? horaFim;

  onInit() async {
    try {
      appointments = await CalendarClient().getGoogleEventsData();

      PageListModel pageList = await _sellerDatasource.getSellerList(
        search: "",
      );
      totalElements = pageList.totalElements;

      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> getAllSellers() async {
    try {
      PageListModel pageList = await _sellerDatasource.getSellerList(
        size: totalElements,
        search: search,
      );

      List<SellerModel>? seller = pageList.content.cast<SellerModel>().toList();

      sellerList.clear();
      _setSellerList(seller);

      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  String convertDateTime({
    required DateTime now,
    bool onlyDate = true,
  }) {
    String convertedDateTime = "";
    onlyDate
        ? convertedDateTime =
            "${now.day.toString()}/${now.month.toString().padLeft(2, '0')}/${now.year.toString().padLeft(2, '0')}"
        : convertedDateTime =
            "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    return convertedDateTime;
  }
}
