import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foodia_chef/feature/auth/login/data/repo/register_repo.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/app_config/app_urls.dart';
import '../../../../../core/helpers/connectivity_helper.dart';
import '../../../../../core/models/exceptions.dart';
import '../../../../../core/models/failures.dart';
import '../../../../../core/network/api_services.dart';
import '../model/auth_response_model/register/register_response_model.dart';

class RegisterRepositoryImpl extends RegisterRepo {
  final ApiService apiService;

  RegisterRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, RegisterResponseModel>> register({
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String name,
    required String email,
    required String bio,
    required XFile image,
  }) async {
    try {
      // تحقق من الاتصال بالانترنت
      if (!await ConnectivityHelper.connected) {
        return const Left(NetworkFailure(AppStrings.checkInternetConnection));
      }

      // تجهيز البيانات لإرسالها مع الـ POST
      final formData = FormData.fromMap({
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'name': name,
        'email': email,
        'bio': bio,
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        ),
      });

      final response = await apiService.post(
        AppUrls.register,
        data: formData,
      );

      log('Register response: $response');

      // هنا التعديل المهم:
      if (response == null || response['status'] != true) {
        return Left(
            AuthFailure(response?['message'] ?? 'Unknown error occurred'));
      }

      final user = RegisterResponseModel.fromJson(response['data']);

      log(user.toJson().toString());

      return Right(user);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
