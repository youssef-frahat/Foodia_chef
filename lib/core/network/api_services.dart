import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../app_config/app_strings.dart';
import '../app_config/prefs_keys.dart';
import '../helpers/connectivity_helper.dart';
import '../helpers/secure_local_storage.dart';
import '../models/exceptions.dart';
import 'dio_factory.dart';


class ApiService {
  final Dio dio;

  ApiService() : dio = DioFactory.getDio() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await SecureLocalStorage.read(PrefsKeys.token);
          if (!options.headers.containsKey('Authorization')) {
            options.headers.addAll({'Authorization': 'Bearer $token'});
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          log(error.toString());
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    if (!await ConnectivityHelper.connected) {
      throw NetworkException(AppStrings.checkInternetConnection.tr());
    }
    final Response response = await dio.get(
      endpoint,
      options: Options(headers: headers),
      queryParameters: queryParameters,
      data: data,
    );
    return response.data;
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    if (!await ConnectivityHelper.connected) {
      throw NetworkException(AppStrings.checkInternetConnection.tr());
    }
    final Response response = await dio.post(
      endpoint,
      options: Options(headers: headers),
      queryParameters: queryParameters,
      data: data,
    );
    log(response.toString());
    return response.data;
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await ConnectivityHelper.connected) {
      throw NetworkException(AppStrings.checkInternetConnection.tr());
    }
    final Response response = await dio.delete(
      endpoint,
      options: Options(headers: headers),
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
