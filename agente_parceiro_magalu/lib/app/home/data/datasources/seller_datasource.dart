import 'dart:convert';

import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:agente_parceiro_magalu/core/http/interceptor/auth_interceptor.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:dio/dio.dart';

abstract class ISellerDatasource {
  Future getSellerByAgenteId();
}

class SellerDatasource implements ISellerDatasource {
  late HttpService _httpWithAuth;

  SellerDatasource() {
    _httpWithAuth = HttpService(
      interceptors: [
        serviceLocator<AuthInterceptor>(),
      ],
    );
  }

  @override
  Future getSellerByAgenteId() async {
    try {
      var user = await SecureStorageHelper.read(key: StorageKeys.loggedUser);
      var encoded = json.encode(user);
      Map<String, dynamic> decoded =
          json.decode(encoded) as Map<String, dynamic>;

      UserModel.fromJson(decoded);

      print(decoded);

      final response = await _httpWithAuth.get(
        Endpoints.getSellerListByAgentId,
        // params = params,
      );
    } on DioError catch (err) {
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
