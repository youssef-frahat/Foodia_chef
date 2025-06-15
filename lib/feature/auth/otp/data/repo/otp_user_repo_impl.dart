import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';

import '../../../../../core/app_config/app_strings.dart';

import '../../../../../core/helpers/connectivity_helper.dart';

import '../../../../../core/models/exceptions.dart';
import '../../../../../core/models/failures.dart';
import '../../../../../core/network/api_services.dart';
import '../model/otp_response_model.dart';
import 'otp_user_repo.dart';

class OtpUserRepoImpl implements OtpUserRepo {
  final ApiService apiService;

  OtpUserRepoImpl(this.apiService);
  @override
  Future<Either<Failure, OtpResponseModel>> verifyOtp({
    required String phoneNumber,
    required String otpCode,
  }) async {
    try {
      if (!await ConnectivityHelper.connected) {
        return Left(NetworkFailure(AppStrings.checkInternetConnection));
      }

      final response = await apiService.post(
        AppUrls.verify,
        data: {'phone': phoneNumber, 'otp': otpCode},
      );
      log('OTP Verification Response: $response');

      if (response['status'] == true) {
        return Right(OtpResponseModel.fromJson(response));
      } else {
        return Left(
          ServerFailure(response['message'] ?? AppStrings.genericError),
        );
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Unexpected error in verifyOtp: $e');
      return Left(ServerFailure(AppStrings.genericError));
    }
  }

  @override
  Future<Either<Failure, OtpResponseModel>> sendOtp({
    required String phoneNumber,
  }) async {
    try {
      if (!await ConnectivityHelper.connected) {
        return Left(NetworkFailure(AppStrings.checkInternetConnection));
      }

      final response = await apiService.post(
        AppUrls.resendcode,
        data: {'phone': phoneNumber},
      );

      if (response['status'] == true && response['message'] != null) {
        log('OTP Sent Successfully: ${response['message']}');
        return Right(OtpResponseModel.fromJson(response));
      } else {
        return Left(
          ServerFailure(response['error'] ?? AppStrings.genericError),
        );
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }
}
