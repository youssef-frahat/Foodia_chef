import 'package:dartz/dartz.dart';
import 'package:foodia_chef/feature/home/data/model/update_status_order_model/update_status_order_req_model.dart';
import 'package:foodia_chef/feature/home/data/model/update_status_order_model/update_status_order_res_model.dart';
import '../../../../../../core/models/failures.dart';

abstract class OrderStatusRepository {
  Future<Either<Failure, UpdateStatusOrderResponseModel>> updateOrderStatus({
    required int orderId,
    required UpdateStatusOrderRequestModel request,
  });
}
