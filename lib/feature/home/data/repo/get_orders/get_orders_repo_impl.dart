import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';
import 'package:foodia_chef/core/helpers/connectivity_helper.dart';
import 'package:foodia_chef/core/models/exceptions.dart';
import 'package:foodia_chef/core/models/failures.dart';
import 'package:foodia_chef/core/network/api_services.dart';
import 'package:foodia_chef/feature/home/data/model/get_orders_model/get_orders_model.dart';
import 'package:foodia_chef/feature/home/data/repo/get_orders/get_orders_repo.dart';

class GetOrdersRepoImpl implements GetOrdersRepo {
  final ApiService apiService;

  GetOrdersRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, GetOrdersModel>> getOrders(String status) async {
    try {
      if (!await ConnectivityHelper.connected) {
        return const Left(NetworkFailure(AppStrings.checkInternetConnection));
      }

      final response = await apiService.get(
        '${AppUrls.base}/home',
        queryParameters: {'status': status},
      );
      final model = GetOrdersModel.fromJson(response);
      return Right(model);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on VerificationException catch (e) {
      return Left(VerificationFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }
}
