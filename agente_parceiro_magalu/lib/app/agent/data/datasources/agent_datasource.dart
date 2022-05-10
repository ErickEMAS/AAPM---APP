import 'package:agente_parceiro_magalu/app/agent/data/models/carteira_model.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/http/exceptions/exceptions.dart';
import '../../../../core/http/interceptor/auth_interceptor.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../../core/models/page_list_model.dart';
import '../models/user_agent_model.dart';

abstract class IAgentDatasource {
  Future<PageListModel> getUsers({required int size, required int page, String? role});
  Future<UserAgentModel> reactiveUser({required String cpf});
  Future<UserAgentModel> desactiveUser({required String id});
  Future<CarteiraModel> getCarteira({required String userId});
}

class AgentDatasource implements IAgentDatasource {
  late HttpService _httpWithAuth;

  AgentDatasource() {
    _httpWithAuth = HttpService(
      interceptors: [
        serviceLocator<AuthInterceptor>(),
      ],
    );
  }

  @override
  Future<PageListModel> getUsers({required int size, required int page, String? role}) async {
    Map<String, dynamic> params = {
      "size": size,
      "page": page,
    };

    if (role != null) params["roleName"] = role;

    try {
      final response = await _httpWithAuth.get(
        Endpoints.getUsers,
        queryParameters: params,
      );
      
      PageListModel pageList = PageListModel.fromJson(response);

      var users = response["content"];

      List<UserAgentModel> dynamicQuestionCheckListModel = (users as List).map((e) => UserAgentModel.fromJson(e)).toList();

      pageList.content = dynamicQuestionCheckListModel;

      return pageList;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      rethrow;
    }
  }

  @override
  Future<UserAgentModel> reactiveUser({required String cpf}) async {
    Map<String, dynamic> data = {
      "cpf": cpf,
    };
    try {
      final response = await _httpWithAuth.post(
        Endpoints.reactivateUser,
        data: data,
      );

      UserAgentModel user = UserAgentModel.fromJson(response);

      return(user);
    } on DioError catch (err) {
      if (err.response!.statusCode == 400) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

   @override
  Future<UserAgentModel> desactiveUser({required String id}) async {
    Map<String, dynamic> data = {
      "id": id,
    };
    try {
      final response = await _httpWithAuth.post(
        Endpoints.deleteUser,
        data: data,
      );

      UserAgentModel user = UserAgentModel.fromJson(response);

      return(user);
    } on DioError catch (err) {
      if (err.response!.statusCode == 400) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }


  @override
  Future<CarteiraModel> getCarteira({required String userId}) async {
    Map<String, dynamic> params = {
      "agentId": userId,
    };
    try {
      final response = await _httpWithAuth.get(
        Endpoints.getCarteira,
        queryParameters: params,
      );
      
      CarteiraModel carteiraModel = CarteiraModel.fromJson(response);

      return carteiraModel;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      rethrow;
    }
  }
  
}
