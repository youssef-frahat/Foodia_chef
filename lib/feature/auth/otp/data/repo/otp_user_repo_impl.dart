import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:foodia_app/core/errors/failures.dart';
import 'package:foodia_app/core/networking/api/api_services.dart';

import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/helpers/connectivity_helper.dart';
import '../../../../../core/networking/api/end_points.dart';
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
        EndPoints.verifyOtp,
        data: {'phone': phoneNumber, 'otp': otpCode},
      );
      log('OTP Verification Response: $response');

      if (response['status'] == true) {
        return Right(OtpResponseModel.fromJson(response));
      } else {
        return Left(
          ServerFailure(response['message'] ?? AppStrings.unexpectedError),
        );
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Unexpected error in verifyOtp: $e');
      return Left(ServerFailure(AppStrings.unexpectedError));
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
        EndPoints.resend,
        data: {'phone': phoneNumber},
      );

      if (response['status'] == true && response['message'] != null) {
        log('OTP Sent Successfully: ${response['message']}');
        return Right(OtpResponseModel.fromJson(response));
      } else {
        return Left(
          ServerFailure(response['error'] ?? AppStrings.unexpectedError),
        );
      }
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.unexpectedError));
    }
  }
}
