import 'dart:convert';

import 'package:agente_parceiro_magalu/app/account/presentation/pages/change_email/change_email_page.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/change_password_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/http/exceptions/exceptions.dart';
import '../../../../core/http/interceptor/auth_interceptor.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../auth/data/models/send_code_model.dart';

abstract class IAccountDatasource {
  Future sendCode({required SendCode sendCode});
  confirmeEmail({required String email, required String code});
  confirmeCodeChangePassword({required String email, required String code});
  changePassword({required ChangePassword changePassword});
  changeEmail({required String code, required String newEmail});
  signUpAgente({required SignUpModel signUpModel});
  signUpAdmin({required SignUpModel signUpModel});
}

class AccountDatasource implements IAccountDatasource {
  late HttpService _httpWithAuth;

  AccountDatasource() {
    _httpWithAuth = HttpService(
      interceptors: [
        serviceLocator<AuthInterceptor>(),
      ],
    );
  }

  @override
  Future signUpAdmin({required SignUpModel signUpModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.signUpAdmin,
        data: signUpModel.toJson(),
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
  Future signUpAgente({required SignUpModel signUpModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.signUpAgente,
        data: signUpModel.toJson(),
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
  Future changeEmail({required String code, required String newEmail}) async {
    Map<String, dynamic> data = {
        "newEmail": newEmail,
        "code": code,
      };
    try {
      final response = await _httpWithAuth.post(
        Endpoints.changeEmail,
        data: data,
      );

      var user = response;

      await SecureStorageHelper.write(
          key: StorageKeys.loggedUser, value: json.encode(user));

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

  @override
  Future confirmeCodeChangePassword({required String email, required String code}) async {
    Map<String, dynamic> data = {
        "email": email,
        "code": code,
      };
    try {
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
  Future confirmeEmail({required String email, required String code}) async {
    Map<String, dynamic> data = {
        "email": email,
        "code": code,
      };
    try {
      final response = await HttpService().post(
        Endpoints.confirmEmail,
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
}
