// import 'package:dio/dio.dart';
// enum RequestMethod { get, post, put, delete, patch }

// class NetworkRequest<GenericModel> {
//   final String path;
//   final RequestMethod method;
//   final Map<String, dynamic>? body;
//   final FormData? formDataBody;
//   final Map<String, dynamic>? queryParameters;
//   final bool requestWithOutToken;
//   bool isFormData;
//   final ProgressCallback? onSendProgress;
//   final ProgressCallback? onReceiveProgress;

//   NetworkRequest(this.path,
//       {required this.method,
//       this.body,
//         this.formDataBody,
//       this.queryParameters,
//       this.requestWithOutToken = false,
//       this.isFormData = false,
//       this.onSendProgress,
//       this.onReceiveProgress});
//   NetworkRequest copyWith({
//     String? path,
//     RequestMethod? method,
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? queryParameters,
//     bool? requestWithOutToken,
//     bool? isFormData,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//   }) {
//     return NetworkRequest(
//       path ?? this.path,
//       method: method ?? this.method,
//       body: body ?? this.body,
//       queryParameters: queryParameters ?? this.queryParameters,
//       requestWithOutToken: requestWithOutToken ?? this.requestWithOutToken,
//       isFormData: isFormData ?? this.isFormData,
//       onSendProgress: onSendProgress ?? this.onSendProgress,
//       onReceiveProgress: onReceiveProgress ?? this.onReceiveProgress,
//     );
//   }
// }
