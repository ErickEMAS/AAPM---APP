import 'package:agente_parceiro_magalu/app/home/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:agente_parceiro_magalu/core/http/interceptor/auth_interceptor.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:dio/dio.dart';

abstract class ISellerDatasource {
  Future<PageListModel> getSellerList({
    required int size,
    required int page,
  });
  Future addSeller({SellerModel? sellerModel});
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
  Future<PageListModel> getSellerList(
      {required int size, required int page}) async {
    try {
      Map<String, dynamic> params = {
        "size": size,
        "page": page,
      };

      final response = await _httpWithAuth.get(
        Endpoints.getSellerListByAgentId,
        queryParameters: params,
      );
      PageListModel pageList = PageListModel.fromJson(response);

      var sellers = response["content"];

      List<SellerModel> listSellerModel =
          (sellers as List).map((e) => SellerModel.fromJson(e)).toList();

      pageList.content = listSellerModel;

      return pageList;
    } on DioError catch (err) {
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future addSeller({SellerModel? sellerModel}) async {
    try {
      if (sellerModel == null) {
        return;
      }

      final response = await _httpWithAuth.post(
        Endpoints.postSeller,
        data: sellerModel.toJson(),
      );

      print(response);
    } on DioError catch (err) {
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
