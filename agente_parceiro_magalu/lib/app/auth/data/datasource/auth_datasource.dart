import 'dart:convert';

import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';

abstract class IAuthDatasource {
  Future login({required String email, required String password});
}

class AuthDatasource implements IAuthDatasource {
  @override
  Future login({required String email, required String password}) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    print(json.encode(data));

    final response = await HttpService().post(
      Endpoints.login,
      data: json.encode(data),
    );

    print(response);
  }
}
