import 'package:agente_parceiro_magalu/app/sellers/data/datasources/seller_datasource.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/api/calendar_api.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
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

  List<Event> appointments = [];

  onInit() async {
    appointments = await CalendarClient().getGoogleEventsData();

    print(appointments);
  }
}
