import 'dart:convert';

import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:dio/dio.dart';

abstract class IAuthDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> verifyCpf({required String cpf});
  Future signUp({required SignUpModel signUpModel});
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

  @override
  Future<UserModel> verifyCpf({
    required String cpf,
  }) async {
    try {
      Map<String, dynamic> params = {
        "cpf": cpf.replaceAll(".", "").replaceAll("-", ""),
      };

      final response = await HttpService().get(
        Endpoints.verifyCPF,
        queryParameters: params,
      );

      UserModel userModel = UserModel.fromJson(response);

      return userModel;
    } on DioError catch (err) {
      print(err);
      if (err.response!.statusCode == 400) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future signUp({
    required SignUpModel signUpModel,
  }) async {
    try {
      signUpModel.cpf = signUpModel.cpf.replaceAll(".", "").replaceAll("-", "");
      final response = await HttpService().post(
        Endpoints.signUp,
        data: json.encode(signUpModel.toJson()),
      );
      print(response);
    } on DioError catch (err) {
      if (err.response!.statusCode == 400) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }
}
