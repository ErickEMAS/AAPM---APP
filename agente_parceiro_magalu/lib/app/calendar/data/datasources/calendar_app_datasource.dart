import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:agente_parceiro_magalu/core/http/interceptor/auth_interceptor.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';

abstract class ICalendarAppDatasource {}

class CalendarAppDatasource implements ICalendarAppDatasource {
  late HttpService _httpWithAuth;

  CalendarDatasource() {
    _httpWithAuth = HttpService(
      interceptors: [
        serviceLocator<AuthInterceptor>(),
      ],
    );
  }
}
