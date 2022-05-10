import 'package:agente_parceiro_magalu/app/calendar/data/datasources/calendar_app_datasource.dart';
import 'package:agente_parceiro_magalu/app/calendar/presentation/stores/agente/calendar_store.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

Future<void> setupCalendarLocators() async {
  serviceLocator.registerLazySingleton<ICalendarAppDatasource>(
    () => CalendarAppDatasource(),
  );

  serviceLocator.registerLazySingleton<CalendarStore>(
    () => CalendarStore(),
  );
}
