import 'dart:convert';

import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:dio/dio.dart';

abstract class IAuthDatasource {
  Future<UserModel> login({required String email, required String password});
}

class AuthDatasource implements IAuthDatasource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "password": password,
      };

      final response = await HttpService().post(
        Endpoints.login,
        data: json.encode(data),
      );

      var user = response['me'];

      return UserModel.fromJson(user);
    } on DioError catch (err) {
      if (err.response!.statusCode == 401) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }
}
