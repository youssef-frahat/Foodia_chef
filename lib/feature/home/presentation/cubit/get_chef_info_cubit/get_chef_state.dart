import 'package:equatable/equatable.dart';

import '../../../data/model/get_orders_model/get_orders_model.dart';

abstract class ChefState extends Equatable {
  const ChefState();

  @override
  List<Object?> get props => [];
}

class ChefInitial extends ChefState {}

class ChefLoading extends ChefState {}

class ChefLoaded extends ChefState {
  final Chef chef;
  final ChefStatistics statistics;

  const ChefLoaded({required this.chef, required this.statistics});

  @override
  List<Object?> get props => [chef, statistics];
}

class ChefError extends ChefState {
  final String message;

  const ChefError(this.message);

  @override
  List<Object?> get props => [message];
}
