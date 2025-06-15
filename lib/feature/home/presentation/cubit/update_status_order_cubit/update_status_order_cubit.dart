import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/feature/home/data/model/update_status_order_model/update_status_order_req_model.dart';
import 'package:foodia_chef/feature/home/data/model/update_status_order_model/update_status_order_res_model.dart';
import 'package:foodia_chef/feature/home/data/repo/update_status_order/update_status_order_repo.dart';

part 'update_status_order_state.dart';

class UpdateOrderStatusCubit extends Cubit<UpdateOrderStatusState> {
  final OrderStatusRepository repository;

  UpdateOrderStatusCubit(this.repository) : super(UpdateOrderStatusInitial());

  Future<void> updateOrderStatus({
    required int orderId,
    required String status,
  }) async {
    emit(UpdateOrderStatusLoading());

    final result = await repository.updateOrderStatus(
      orderId: orderId,
      request: UpdateStatusOrderRequestModel(status: status),
    );

    result.fold(
      (failure) {
        emit(UpdateOrderStatusError(failure.message));
      },
      (response) {
        emit(UpdateOrderStatusSuccess(response));
      },
    );
  }
}
