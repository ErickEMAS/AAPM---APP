import 'dart:convert';

import 'package:agente_parceiro_magalu/app/auth/data/models/change_password_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/send_code_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/user_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/constants/storage_keys.dart';
import 'package:agente_parceiro_magalu/core/helpers/storage_helper.dart';
import 'package:agente_parceiro_magalu/core/http/exceptions/exceptions.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:dio/dio.dart';

abstract class IAuthDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> verifyCpf({required String cpf});
  Future signUp({required SignUpModel signUpModel});
  Future sendCode({required SendCode sendCode});
  Future confirmeCode({required String email, required String code});
  Future changePassword({required ChangePassword changePassword});
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

      UserModel userModel = UserModel.fromJson(user);

      await SecureStorageHelper.write(
          key: StorageKeys.token, value: response["access_token"]);

      var Token = await SecureStorageHelper.read(
        key: StorageKeys.token,
      );

      print("TOKEN AQUI $Token");

      await SecureStorageHelper.write(
          key: StorageKeys.loggedUser, value: json.encode(user));

      await SecureStorageHelper.write(
          key: StorageKeys.userRole, value: userModel.roles[0]);

      return userModel;
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

  @override
  Future sendCode({required SendCode sendCode}) async {
    try {
      final response = await HttpService().post(
        Endpoints.sendCode,
        data: sendCode.toJson(),
      );

      print(response);
    } on DioError catch (err) {
      if (err.response!.statusCode == 400) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future confirmeCode({required String email, required String code}) async {
    try {
      Map<String, dynamic> data = {
        "email": email,
        "code": code,
      };

      final response = await HttpService().post(
        Endpoints.confirmCodeChangePassword,
        data: data,
      );

      print(response);
    } on DioError catch (err) {
      if (err.response!.statusCode == 400) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future changePassword({required ChangePassword changePassword}) async {
    try {
      final response = await HttpService().post(
        Endpoints.changePassword,
        data: changePassword.toJson(),
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
