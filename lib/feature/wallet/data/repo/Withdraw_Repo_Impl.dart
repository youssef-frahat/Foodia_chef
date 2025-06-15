import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';

import '../../../../core/app_config/app_strings.dart';
import '../../../../core/models/exceptions.dart';
import '../../../../core/models/failures.dart';
import '../../../../core/network/api_services.dart';
import '../model/Submit_Withdraw_Model/Submit_Withdraw_Model.dart';
import '../model/get_wallet_model/Withdraw_Response_Model.dart';
import 'withdraw_repo.dart';

class WithdrawRepoImpl implements WithdrawRepo {
  final ApiService apiServices;

  WithdrawRepoImpl(this.apiServices);

  @override
  Future<Either<Failure, WithdrawResponseModel>> getWithdraws() async {
    try {
      final response = await apiServices.get(AppUrls.withdraws);
      final result = WithdrawResponseModel.fromJson(response);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }

  @override
  Future<Either<Failure, SubmitWithdrawModel>> submitWithdraw({
    required int amount,
  }) async {
    try {
      final response = await apiServices.post(
        AppUrls.withdraws,
        data: {'amount': amount},
      );
      final result = SubmitWithdrawModel.fromJson(response);
      return Right(result);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }
}
