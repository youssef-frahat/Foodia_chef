import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../app_config/prefs_keys.dart';
import '../helpers/secure_local_storage.dart';
import '../routes/app_router.dart';
import '../routes/routes.dart';

class CustomInterceptor extends Interceptor {
  final Dio dio;

  CustomInterceptor({
    required this.dio,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      HttpHeaders.acceptHeader: ContentType.json,
      'Accept-Language': AppRouter.appNavigatorKey.currentContext!.locale.languageCode,
      'time-zone': DateTime.now().timeZoneName,
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
  
      await _logout();
      handler.reject(err); 
    } else {
      handler.next(err); 
    }
  }

  Future<void> _logout() async {
    await SecureLocalStorage.delete(PrefsKeys.token);
    dio.options.headers.clear();
    GoRouter.of(AppRouter.appNavigatorKey.currentContext!)
        .pushReplacementNamed(Routes.login);
  }
}
