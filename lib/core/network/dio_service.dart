// import 'dart:io';

// import 'package:alice/core/alice_logger.dart';
// import 'package:alice/model/alice_configuration.dart';
// import 'package:alice_dio/alice_dio_adapter.dart';
// import 'package:alice/alice.dart';

// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:foodia_chef/core/network/extensions.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// import '../app_config/app_urls.dart';
// import '../app_config/constants.dart';
// import '../app_config/prefs_keys.dart';
// import '../helpers/secure_local_storage.dart';
// import '../models/errors_exceptions_handler.dart';
// import '../routes/app_router.dart';
// import 'interceptors.dart';
// import 'network_request.dart';
// import 'network_service.dart';

// class DioService implements NetworkService {
//   late Dio _dio;
//   static Alice alice = Alice(
//       configuration: AliceConfiguration(
//           showShareButton: true,
//           navigatorKey: AppRouter.appNavigatorKey,
//           showInspectorOnShake: true,
//           showNotification: true));
//   DioService() {
//     _initDio();
//   }

//   void _initDio() {
//     _dio = Dio()
//       ..options.baseUrl = AppUrls.baseApi
//       ..options.connectTimeout = const Duration(seconds: 30)
//       ..options.receiveTimeout = const Duration(seconds: 30)
//       ..options.validateStatus = (status) {
//         // false => dio will validate it as error so the onError callback is invoked .. true => normal response
//         // to handle it as error so the interceptor can detect the token expiration and refresh it.
//         if (status == 401) {
//           return false;
//         } else if (status == 500) {
//           return false;
//         }
//         return status! < 400;
//       }
//       ..options.responseType = ResponseType.json;

//     if (kDebugMode) {
//       /// Create Alice Dio Adapter
//       AliceDioAdapter aliceDioAdapter = AliceDioAdapter();

//       /// Add adapter to Alice
//       alice.addAdapter(aliceDioAdapter);

//       /// Add interceptor to Dio
//       _dio.interceptors.add(aliceDioAdapter);
//       _dio.interceptors.add(PrettyDioLogger(
//         requestHeader: true,
//         requestBody: true,
//         responseHeader: true,
//         responseBody: true,
//       ));
//       _dio.interceptors.add(CustomInterceptor(dio: _dio));
//     }
//   }

//   Future<Map<String, dynamic>> _getDefaultHeaders(bool isWithoutToken) async {
//     final Map<String, dynamic> headers = {};
// /*
//     headers.addAll({
//       HttpHeaders.acceptHeader: ContentType.json,
//       'Accept-Language':
//           AppRouter.parentNavigatorKey.currentContext!.locale.languageCode,
//       'time-zone': 'en',
//     });*/
//     if (isWithoutToken != true) {
//       final token = await SecureLocalStorage.read(PrefsKeys.token);
//       if (token?.isNotEmpty == true) {
//         headers[AppConstants.authorization] = '${AppConstants.bearer} $token';
//       }
//     }
//     return headers;
//   }

//   @override
//   Future<Model> callApi<Model>(NetworkRequest networkRequest,
//       {Model Function(Map<String, dynamic> json)? mapper}) async {
//     try {
//       await networkRequest.prepareRequestData();
//       final response = await _dio.request(networkRequest.path,
//           data: networkRequest.hasBodyAndProgress()
//               ? networkRequest.isFormData
//                   ? networkRequest
//                       .formDataBody /* FormData.fromMap(networkRequest.body!)*/
//                   : networkRequest.body
//               : networkRequest.body,
//           queryParameters: networkRequest.queryParameters,
//           onSendProgress: networkRequest.hasBodyAndProgress()
//               ? networkRequest.onSendProgress
//               : null,
//           onReceiveProgress: networkRequest.hasBodyAndProgress()
//               ? networkRequest.onReceiveProgress
//               : null,
//           options: Options(
//               method: networkRequest.asString(),
//               headers: await _getDefaultHeaders(
//                   networkRequest.requestWithOutToken)));
//       if (mapper != null &&
//           (response.statusCode == 200 ||
//               response.statusCode == 201 ||
//               response.statusCode == 204)) {
//         return mapper(response.data);
//       } else {
//         debugPrint('else: ${response.data}');
//         return response.data;
//       }
//     } on DioException catch (e) {
//       return ErrorsExceptionsHandler.handleError(e);
//     }
//   }
// }
