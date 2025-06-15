part of 'get_orders_cubit.dart';

@immutable
sealed class GetOrdersState extends Equatable {
  const GetOrdersState();

  @override
  List<Object> get props => [];
}

final class GetOrdersInitial extends GetOrdersState {}

final class GetOrdersLoading extends GetOrdersState {}

final class GetOrdersSuccess extends GetOrdersState {
  final GetOrdersModel orders;

  const GetOrdersSuccess(this.orders);

  @override
  List<Object> get props => [orders];
}

final class GetOrdersFailure extends GetOrdersState {
  final String error;

  const GetOrdersFailure(this.error);

  @override
  List<Object> get props => [error];
}
