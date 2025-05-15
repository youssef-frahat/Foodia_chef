import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';

import '../../../../core/app_config/app_strings.dart';
import '../../../../core/models/exceptions.dart';
import '../../../../core/models/failures.dart';
import '../../../../core/network/api_services.dart';
import '../model/add_to_balance_model/add_to_balance_model.dart';
import '../model/get_wallet_model/get_wallet_model.dart';
import 'wallet_repo.dart';

class WaletRepoImpl implements WalletRepo {
  final ApiService apiServices;

  WaletRepoImpl(this.apiServices);

  @override
  Future<Either<Failure, GetWalletModel>> getBalance() async {
    try {
      final response = await apiServices.get(AppUrls.balance);
      GetWalletModel balance = GetWalletModel.fromJson(response);
      return Right(balance);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }

  @override
  Future<Either<Failure, AddToBalanceModel>> addBalance({
    required int amount,
  }) async {
    try {
      final response = await apiServices.post(
        AppUrls.addBalance,
        data: {'amount': amount},
      );
      AddToBalanceModel addToBalanceModel = AddToBalanceModel.fromJson(
        response,
      );
      return Right(addToBalanceModel);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(AppStrings.genericError));
    }
  }
}
