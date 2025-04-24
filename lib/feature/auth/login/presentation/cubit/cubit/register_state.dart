import 'package:equatable/equatable.dart';

enum RegisterErrorSource {
  sendOtp,
  verifyOtp,
  register,
}

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String message;

  RegisterSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterOtpSent extends RegisterState {
  final String message;

  RegisterOtpSent({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterError extends RegisterState {
  final String error;
  final RegisterErrorSource source;

  RegisterError({required this.error, required this.source});

  @override
  List<Object> get props => [error, source];
}
