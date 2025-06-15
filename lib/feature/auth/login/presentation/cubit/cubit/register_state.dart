import 'package:equatable/equatable.dart';

import '../../../data/model/auth_response_model/register/register_response_model.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponseModel user;
  const RegisterSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class RegisterError extends RegisterState {
  final String error;
  const RegisterError(this.error);

  @override
  List<Object> get props => [error];
}
