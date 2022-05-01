import 'dart:io';

import 'package:agente_parceiro_magalu/core/app_config.dart';
import 'package:agente_parceiro_magalu/core/locators/service_locators.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const int _receiveTimeout = Duration.millisecondsPerMinute;
const int _connectionTimeout = 150000;

class HttpService {
  final Dio _dio = serviceLocator<Dio>();
  final Iterable<Interceptor> interceptors;
  final bool? refreshToken;

  HttpService({
    this.interceptors = const [],
    this.refreshToken = true,
  }) {
    _dio
      ..options.baseUrl = AppConfig.baseUrl
      ..options.connectTimeout = _connectionTimeout
      ..options.receiveTimeout = _receiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    // if (refreshToken) _dio.interceptors.add(RefreshTokenInterceptor());
    if (interceptors.isNotEmpty) _dio.interceptors.addAll(interceptors);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print("header: ${options.headers}");

            print("full url: ${options.uri}");
            print("");
            print("________________________");
            print("");
            print(
                'send request：baseURL:${options.baseUrl}, path:${options.path}， body: ${options.data}, query params${options.queryParameters}');
            print("");
            print("________________________");
            print("");
          }

          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          if (kDebugMode) {
            print(response.data);
            print(response.statusCode);
            print(response.statusMessage);
          }
          return handler.next(response);
        },
      ),
    );

    // _dio.interceptors.add(
    //   LogInterceptor(
    //     error: true,
    //     // requestBody: true,
    //     // responseHeader: false,
    //     // responseBody: true,
    //   ),
    // );
  }

  dynamic _defaultHttpExceptionHandler(DioError error) {
    print(error.message);
    print(error.error);
  }

  Future<dynamic> get(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.toString());
    } on FormatException catch (error) {
      throw FormatException(error.toString());
    } on DioError catch (error) {
      _defaultHttpExceptionHandler(error);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.toString());
    } on FormatException catch (error) {
      throw FormatException(error.toString());
    } on DioError catch (error) {
      _defaultHttpExceptionHandler(error);
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> request(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data;
    } on SocketException catch (error) {
      throw SocketException(error.toString());
    } on FormatException catch (error) {
      throw FormatException(error.toString());
    } on DioError catch (error) {
      _defaultHttpExceptionHandler(error);
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
