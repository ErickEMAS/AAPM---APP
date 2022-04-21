import 'dart:io';

import 'package:agente_parceiro_magalu/core/app_config.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

const int _receiveTimeout = Duration.millisecondsPerMinute;
const int _connectionTimeout = 150000;

class HttpService {
  final Dio _dio = Dio();

  HttpService() {
    _dio
      ..options.baseUrl = AppConfig.baseUrl
      ..options.connectTimeout = _connectionTimeout
      ..options.receiveTimeout = _receiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };

    _dio.clear();

    // if (refreshToken) _dio.interceptors.add(RefreshTokenInterceptor());
    // if (interceptors.isNotEmpty) _dio.interceptors.addAll(interceptors);

    // _dio.interceptors.add(
    //   LogInterceptor(
    //     requestBody: true,
    //     responseHeader: false,
    //     responseBody: true,
    //   ),
    // );
  }
  dynamic _defaultHttpExceptionHandler(DioError error) {
    if (error.response != null &&
        error.response!.data.toString().contains('ECONNREFUSED')) {
      // throw ConnectionRefused(message: 'ERROR.ERROR_CONNECTION');
    }
    if (error.type == DioErrorType.connectTimeout) {
      // throw ConnectionTimeOut(message: "ERROR.ERROR_CONNECTION");
    }
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
