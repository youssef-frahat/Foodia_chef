import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../core/app_config/app_strings.dart';
import '../../../../core/app_config/prefs_keys.dart';
import '../../../../core/helpers/connectivity_helper.dart';
import '../../../../core/helpers/secure_local_storage.dart';
import '../../../../core/models/exceptions.dart';
import '../../../../core/models/failures.dart';
import '../../../../core/network/api_services.dart';
import '../model/edit_user_profile_model/edit_user_profile_model.dart';
import '../model/get_user_profile_model/get_user_profile_model.dart';
import 'get_user_profile_repo.dart';

class GetUserProfileRepoImpl implements GetUserProfileRepo {
  final ApiService apiService;

  GetUserProfileRepoImpl(this.apiService);

  @override
  Future<Either<Failure, GetUserProfileModel>> getUserProfile() async {
    try {
      if (!await ConnectivityHelper.connected) {
        return const Left(NetworkFailure(AppStrings.checkInternetConnection));
      }

      final response = await apiService.get(AppUrls.profile);
      log('Get user Profile response: $response');

      if (response == null || response['data'] == null) {
        return Left(ServerFailure("No data found"));
      }

      final GetUserProfileModel user = GetUserProfileModel.fromJson(response);

      log('Get user Profile model: ${user.toJson()}');
      return Right(user);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Unexpected error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await apiService.post(
        AppUrls.logout,
        headers: {
          'Authorization':
              'Bearer ${await SecureLocalStorage.read(PrefsKeys.token)}',
        },
      );
      await SecureLocalStorage.delete(PrefsKeys.token);
      await SecureLocalStorage.delete(PrefsKeys.user);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }

  @override
  Future<Either<Failure, EditUserProfileModel>> updateUserProfile({
    required String name,
    required String email,
    required String phone,
    required String bio,
    String? password,
    String? passwordConfirmation,
    String? currentPassword,
    required XFile? image,
  }) async {
    try {
      if (!await ConnectivityHelper.connected) {
        return const Left(NetworkFailure(AppStrings.checkInternetConnection));
      }

      final data = {
        'name': name,
        'email': email,
        'phone': phone,
        'bio': bio,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'current_password': currentPassword,
        'image':
            image != null ? await MultipartFile.fromFile(image.path) : null,
      };

      final response = await apiService.post(
        AppUrls.editProfile,
        data: FormData.fromMap(data),
      );

      log('Update user Profile response: $response');

      if (response == null || response['data'] == null) {
        return Left(ServerFailure("No data found"));
      }

      final EditUserProfileModel user = EditUserProfileModel.fromJson(response);

      log('Update user Profile model: ${user.toJson()}');
      return Right(user);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Unexpected error: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
