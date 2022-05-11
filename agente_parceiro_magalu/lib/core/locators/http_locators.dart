import 'package:agente_parceiro_magalu/core/http/interceptor/auth_interceptor.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:dio/dio.dart';

Future<void> setupHttpLocators() async {
  serviceLocator.registerFactory<Dio>(
    () => Dio(),
  );
  serviceLocator.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(),
  );
}
