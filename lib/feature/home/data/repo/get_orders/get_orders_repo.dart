import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/models/failures.dart';
import 'package:foodia_chef/feature/home/data/model/get_orders_model/get_orders_model.dart';

abstract class GetOrdersRepo {
  Future<Either<Failure, GetOrdersModel>> getOrders(String status);
}
