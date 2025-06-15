part of 'otp_user_cubit.dart';

sealed class OtpUserState extends Equatable {
  const OtpUserState();

  @override
  List<Object> get props => [];
}

final class OtpUserInitial extends OtpUserState {}

final class SendOtpCodeLoading extends OtpUserState {}

final class SendOtpCodeSuccess extends OtpUserState {}

final class SendOtpCodeError extends OtpUserState {
  final String error;

  const SendOtpCodeError(this.error);

  @override
  List<Object> get props => [error];
}

final class ValidateOtpCodeLoading extends OtpUserState {}

final class ValidateOtpCodeSuccess extends OtpUserState {}

final class ValidateOtpCodeError extends OtpUserState {
  final String error;

  const ValidateOtpCodeError(this.error);

  @override
  List<Object> get props => [error];
}
