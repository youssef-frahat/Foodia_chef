import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foodia_chef/feature/home/data/model/get_orders_model/get_orders_model.dart';
import 'package:foodia_chef/feature/home/data/repo/get_orders/get_orders_repo.dart';

part 'get_orders_state.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  final GetOrdersRepo chefOrdersRepo;

  GetOrdersCubit(this.chefOrdersRepo) : super(GetOrdersInitial());

  Future<void> fetchOrders(String status) async {
    emit(GetOrdersLoading());

    final result = await chefOrdersRepo.getOrders(status);

    result.fold(
      (failure) => emit(GetOrdersFailure(failure.message)),
      (orders) => emit(GetOrdersSuccess(orders)),
    );
  }
}
