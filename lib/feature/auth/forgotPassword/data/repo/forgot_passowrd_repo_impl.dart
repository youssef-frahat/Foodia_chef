import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';
import 'package:foodia_chef/feature/auth/forgotPassword/data/repo/forgot_passowrd_repo.dart';

import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/models/exceptions.dart';
import '../../../../../core/models/failures.dart';
import '../../../../../core/network/api_services.dart';
import '../model/forget_passowrd_model.dart';
import '../model/password_reset_model.dart';

class ForgotPassowrdRepoImpl implements ForgotPassowrdRepo {
  final ApiService apiService;

  ForgotPassowrdRepoImpl(this.apiService);
  @override
  Future<Either<Failure, ForgetPassowrdModel>> forgetPassword({
    required String phone,
  }) async {
    try {
      final response = await apiService.post(
        AppUrls.forgetPassword,
data: {'phone': phone},
      );
      final forgetPassowrdModel = ForgetPassowrdModel.fromJson(response);
      return Right(forgetPassowrdModel);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }

  @override
  Future<Either<Failure, PasswordResetModel>> resetPassword({
    required String phone,
    required String password,
    required String conPassword,
  }) async {
    try {
      final response = await apiService.post(
        AppUrls.resetPassword,
        data: {
          'phone': phone,
          'password': password,
          'password_confirmation': conPassword,
        },
      );
      final resetPassowrdModel = PasswordResetModel.fromJson(response);
      return Right(resetPassowrdModel);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }
}
