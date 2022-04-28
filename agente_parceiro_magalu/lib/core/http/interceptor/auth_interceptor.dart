import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final bearer = await SecureStorageHelper.read(key: StorageKeys.token);

    options.headers.addAll({'Authorization': 'Bearer $bearer'});

    return super.onRequest(options, handler);
  }
}
