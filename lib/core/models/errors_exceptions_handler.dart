

// import 'package:dio/dio.dart';

// import 'exceptions.dart';

// class ErrorsExceptionsHandler {
//   static dynamic handleError(DioException error) {
//     final String? errorMessage = error.response?.data['message'];
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         throw CustomException(errorMessage ?? 'BadRequestException');
//       case DioExceptionType.sendTimeout:
//         throw CustomException(errorMessage ?? 'BadRequestException');
//       case DioExceptionType.receiveTimeout:
//         throw CustomException(errorMessage ?? 'BadRequestException');
//       case DioExceptionType.badResponse:
//         switch (error.response!.statusCode) {
//           case 400:
//             throw BadRequestException(errorMessage ?? 'BadRequestException');
//           case 403:
//             throw CustomException(errorMessage ?? 'BadRequestException',code: 403);
//           case 401:
//             throw UnauthorizedException(errorMessage ?? 'BadRequestException');
//           case 404:
//              throw  NotFoundException(errorMessage ?? 'BadRequestException');
//           case 409:
//             throw ConflictException(
//                 errorMessage ?? 'BadRequestException');
//           case 500:
//             throw InternalServerErrorException(
//                 errorMessage ?? 'BadRequestException');
//           case 501:
//             throw InternalServerErrorException(
//                 errorMessage ?? 'BadRequestException');
//           case 502:
//             throw InternalServerErrorException(
//                 errorMessage ?? 'BadRequestException');
//           case 503:
//             throw InternalServerErrorException(
//                 errorMessage ?? 'BadRequestException');
//           default:
//             throw CustomException(errorMessage ?? 'BadRequestException');
//         }
//       case DioExceptionType.cancel:
//         throw const CustomException('request_cancelled');
//       case DioExceptionType.unknown:
//         throw CustomException(
//             errorMessage ?? 'BadRequestException');
//       default:
//         throw CustomException(
//             errorMessage ?? 'BadRequestException');
//     }
//   }
// }
