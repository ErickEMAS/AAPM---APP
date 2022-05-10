import 'dart:convert';

import 'package:agente_parceiro_magalu/app/account/data/models/faq_model.dart';
import 'package:agente_parceiro_magalu/app/account/data/models/hunting_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/change_password_model.dart';
import 'package:agente_parceiro_magalu/app/auth/data/models/sign_up_model.dart';
import 'package:agente_parceiro_magalu/core/constants/api_endpoints.dart';
import 'package:agente_parceiro_magalu/core/http/http_service.dart';
import 'package:agente_parceiro_magalu/core/models/page_list_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/storage_keys.dart';
import '../../../../core/helpers/storage_helper.dart';
import '../../../../core/http/exceptions/exceptions.dart';
import '../../../../core/http/interceptor/auth_interceptor.dart';
import '../../../../core/locators/service_locators.dart';
import '../../../agent/data/models/carteira_model.dart';
import '../../../auth/data/models/send_code_model.dart';
import '../../../sellers/data/models/tag_model.dart';
import '../models/dynamic_field_model.dart';
import '../models/dynamic_question_checkList_model.dart';

abstract class IAccountDatasource {
  Future sendCode({required SendCode sendCode});
  Future confirmeEmail({required String email, required String code});
  Future confirmeCodeChangePassword(
      {required String email, required String code});
  Future changePassword({required ChangePassword changePassword});
  Future changeEmail({required String code, required String newEmail});
  Future signUpAgente({required SignUpModel signUpModel});
  Future signUpAdmin({required SignUpModel signUpModel});
  Future<List<TagModel>> getTagList();
  Future addTag({required TagModel tagModel});
  Future updateTag({required TagModel tagModel});
  Future<PageListModel> getFAQs({required int size, required int page, required String search});
  Future addFAQ({required FAQModel faqModel});
  Future updateFAQ({required FAQModel faqModel});
  Future<PageListModel> getDynamicQuestionCheckLists({required int size, required int page, required String status});
  Future addDynamicQuestionCheckList({required DynamicQuestionCheckListModel dynamicQuestionCheckListModel});
  Future updateDynamicQuestionCheckList({required DynamicQuestionCheckListModel dynamicQuestionCheckListModel});
  Future<PageListModel> getDynamicFields({required int size, required int page});
  Future addDynamicField({required DynamicFieldModel dynamicFieldModel});
  Future updateDynamicField({required DynamicFieldModel dynamicFieldModel});
  Future<PageListModel> getCarteiras({required int size, required int page});
  Future transferCarteira({required String userId, required String carteiraId});
  Future addHunting({required HuntingModel huntingModel});
  Future updateHunting({required HuntingModel huntingModel});
  Future<PageListModel> getHuntings({required int size, required int page});
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
  Future<List<TagModel>> getTagList() async {
    try {
      final response = await _httpWithAuth.get(
        Endpoints.getTags,
      );

      print(response);

      List<TagModel> tags =
          (response as List).map((e) => TagModel.fromJson(e)).toList();

      return tags;
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
  Future confirmeCodeChangePassword(
      {required String email, required String code}) async {
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

  @override
  Future addTag({required TagModel tagModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.addTag,
        data: tagModel.toJson(),
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
  Future updateTag({required TagModel tagModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.updateTag,
        data: tagModel.toJson(),
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
  Future addFAQ({required FAQModel faqModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.addFAQ,
        data: faqModel.toJson(),
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
  Future updateFAQ({required FAQModel faqModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.updateFAQ,
        data: faqModel.toJson(),
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
  Future<PageListModel> getFAQs(
      {required int size, required int page, required String search}) async {
    Map<String, dynamic> params = {
      "size": size,
      "page": page,
      "search": search,
    };

    try {
      final response = await _httpWithAuth.get(
        Endpoints.getFAQs,
        queryParameters: params,
      );
      
      PageListModel pageList = PageListModel.fromJson(response);

      var faqs = response["content"];

      List<FAQModel> listFAQModel = (faqs as List).map((e) => FAQModel.fromJson(e)).toList();

      pageList.content = listFAQModel;

      return pageList;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      rethrow;
    }
  }

  @override
  Future addDynamicQuestionCheckList({required DynamicQuestionCheckListModel dynamicQuestionCheckListModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.addQuestion,
        data: dynamicQuestionCheckListModel.toJson(),
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
  Future updateDynamicQuestionCheckList({required DynamicQuestionCheckListModel dynamicQuestionCheckListModel}) async {
    Map<String, dynamic> data = {
    "id": dynamicQuestionCheckListModel.id,
    "question": "Multiplas alternativas",
    "alternatives": dynamicQuestionCheckListModel.alternatives.map((e) => e.toJson()).toList(),
    "answerRequired": dynamicQuestionCheckListModel.answerRequired,
    "multipleAlternative": dynamicQuestionCheckListModel.multipleAlternative,
    "active": dynamicQuestionCheckListModel.active,
    "fieldUpdate": dynamicQuestionCheckListModel.fieldUpdate.toJson()
};
    try {
      final response = await _httpWithAuth.post(
        Endpoints.updateQuestion,
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
  Future<PageListModel> getDynamicQuestionCheckLists({required int size, required int page, required String status}) async {
    Map<String, dynamic> params = {
      "size": size,
      "page": page,
      "status": status,
    };

    try {
      final response = await _httpWithAuth.get(
        Endpoints.getQuestions,
        queryParameters: params,
      );
      
      PageListModel pageList = PageListModel.fromJson(response);

      var dynamicQuestionCheckList = response["content"];

      List<DynamicQuestionCheckListModel> dynamicQuestionCheckListModel = (dynamicQuestionCheckList as List).map((e) => DynamicQuestionCheckListModel.fromJson(e)).toList();

      pageList.content = dynamicQuestionCheckListModel;

      return pageList;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      rethrow;
    }
  }

  @override
  Future addDynamicField({required DynamicFieldModel dynamicFieldModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.addField,
        data: dynamicFieldModel.toJson(),
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
  Future updateDynamicField({required DynamicFieldModel dynamicFieldModel}) async {
    try {
      // final response = await _httpWithAuth.post(
      //   Endpoints.up,
      //   data: dynamicFieldModel.toJson(),
      // );

      // print(response);
    } on DioError catch (err) {
      if (err.response!.statusCode == 400) throw Unauthorized();
      rethrow;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<PageListModel> getDynamicFields({required int size, required int page}) async {
    Map<String, dynamic> params = {
      "size": size,
      "page": page,
    };

    try {
      final response = await _httpWithAuth.get(
        Endpoints.getFields,
        queryParameters: params,
      );
      
      PageListModel pageList = PageListModel.fromJson(response);

      var dynamicFields = response["content"];

      List<DynamicFieldModel> dynamicFieldModel = (dynamicFields as List).map((e) => DynamicFieldModel.fromJson(e)).toList();

      pageList.content = dynamicFieldModel;

      return pageList;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      rethrow;
    }
  }

  @override
  Future addHunting({required HuntingModel huntingModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.addHunting,
        data: huntingModel.toJson(),
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
  Future updateHunting({required HuntingModel huntingModel}) async {
    try {
      final response = await _httpWithAuth.post(
        Endpoints.updateHunting,
        data: huntingModel.toJson(),
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
  Future<PageListModel> getHuntings({required int size, required int page}) async {
    Map<String, dynamic> params = {
      "size": size,
      "page": page,
    };

    try {
      final response = await _httpWithAuth.get(
        Endpoints.getHuntings,
        queryParameters: params,
      );
      
      PageListModel pageList = PageListModel.fromJson(response);

      var hunting = response["content"];

      List<HuntingModel> dynamicFieldModel = (hunting as List).map((e) => HuntingModel.fromJson(e)).toList();

      pageList.content = dynamicFieldModel;

      return pageList;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      rethrow;
    }
  }

  @override
  Future<PageListModel> getCarteiras({required int size, required int page}) async {
    Map<String, dynamic> params = {
      "size": size,
      "page": page,
    };

    try {
      final response = await _httpWithAuth.get(
        Endpoints.getCarteiraWithoutOwner,
        queryParameters: params,
      );
      
      PageListModel pageList = PageListModel.fromJson(response);

      var carteira = response["content"];

      List<CarteiraModel> dynamicQuestionCheckListModel = (carteira as List).map((e) => CarteiraModel.fromJson(e)).toList();

      pageList.content = dynamicQuestionCheckListModel;

      return pageList;
    } catch (err) {
      // ignore: avoid_print
      print(err);
      rethrow;
    }
  }

  @override
  Future transferCarteira({required String userId, required String carteiraId}) async {
    Map<String, dynamic> data = {
      "userId": userId,
      "carteiraId": carteiraId,
    };

    try {
      final response = await _httpWithAuth.post(
        Endpoints.addField,
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
}
