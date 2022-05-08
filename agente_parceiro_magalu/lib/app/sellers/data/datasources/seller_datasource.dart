import 'dart:convert';
import 'package:agente_parceiro_magalu/app/sellers/data/models/checklist_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/question_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/seller_model.dart';
import 'package:agente_parceiro_magalu/app/sellers/data/models/tag_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:agente_parceiro_magalu/core/http/interceptor/auth_interceptor.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:dio/dio.dart';

abstract class ISellerDatasource {
  Future<PageListModel> getSellerList({
    int? size,
    int? page,
    String? tagId,
    String? nome,
  });
  Future addSeller({SellerModel? sellerModel});
  Future<String> addSellerList({required List<SellerModel> sellerModelList});
  Future<SellerModel> getSellerById({String? sellerId});
  Future<List<TagModel>> getTags();
  Future addTag({required TagModel tagModel});
  Future addTagInSeller({required String sellerId, required String tagId});

  Future<ChecklistModel> startChecklistBySellerId({required String sellerId});

  Future answerChecklist({
    required ChecklistModel checklistModel,
  });
  Future getChecklistHistorico({required String sellerId});
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
  Future<PageListModel> getSellerList({
    int? size,
    int? page,
    String? tagId,
    String? nome,
  }) async {
    try {
      Map<String, dynamic> params = {
        "size": size,
        "page": page,
      };

      final tagIdParam = <String, dynamic>{"tagId": tagId};
      tagId != null ? params.addEntries(tagIdParam.entries) : null;

      final nomeParam = <String, dynamic>{"nome": nome};
      nome != null ? params.addEntries(nomeParam.entries) : null;

      final response = await _httpWithAuth.get(
        Endpoints.getSellerListByAgentId,
        queryParameters: size != null ? params : null,
      );
      PageListModel pageList = PageListModel.fromJson(response);

      var sellers = response["content"];

      List<SellerModel> listSellerModel =
          (sellers as List).map((e) => SellerModel.fromJson(e)).toList();

      pageList.content = listSellerModel;

      return pageList;
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
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future<String> addSellerList(
      {required List<SellerModel> sellerModelList}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.addSellerList,
        data: sellerModelList.map((seller) => seller.toJson()).toList(),
      );

      print(response);
      return (response);
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future<SellerModel> getSellerById({String? sellerId}) async {
    try {
      Map<String, dynamic> params = {
        "sellerId": sellerId,
      };

      final response = await _httpWithAuth.get(
        Endpoints.getSellerById,
        queryParameters: params,
      );

      SellerModel sellerModel = SellerModel.fromJson(response);

      return sellerModel;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future<List<TagModel>> getTags() async {
    try {
      final response = await _httpWithAuth.get(
        Endpoints.getTags,
      );

      List<TagModel> tags =
          (response as List).map((e) => TagModel.fromJson(e)).toList();

      return tags;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future getChecklistHistorico({required String sellerId}) async {
    try {
      Map<String, dynamic> params = {
        "sellerId": sellerId,
      };

      final response = await _httpWithAuth.get(
        Endpoints.getChecklists,
        queryParameters: params,
      );

      // SellerModel sellerModel = SellerModel.fromJson(response);
      print(response);
      return;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future addTag({required TagModel tagModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.addTag,
        data: tagModel.toJson(),
      );

      print(response);
    } on DioError catch (err) {
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future addTagInSeller(
      {required String sellerId, required String tagId}) async {
    try {
      Map<String, dynamic> params = {
        "sellerId": sellerId,
        "tagId": tagId,
      };

      final response = await _httpWithAuth.post(
        Endpoints.addTagInSelelr,
        data: params,
      );

      print(response);
    } on DioError catch (err) {
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future<ChecklistModel> startChecklistBySellerId(
      {required String sellerId}) async {
    try {
      Map<String, dynamic> params = {
        "id": sellerId,
      };

      final response = await _httpWithAuth.post(
        Endpoints.startChecklist,
        data: json.encode(params),
      );
      ChecklistModel checklistModel = ChecklistModel.fromJson(response);

      return checklistModel;
    } on DioError catch (err) {
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  @override
  Future answerChecklist({
    required ChecklistModel checklistModel,
  }) async {
    try {
      var json = checklistModel.toJson();

      final response = await _httpWithAuth.post(
        Endpoints.answerChecklist,
        data: json,
      );

      print(response);
    } on DioError catch (err) {
      print(err);
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
