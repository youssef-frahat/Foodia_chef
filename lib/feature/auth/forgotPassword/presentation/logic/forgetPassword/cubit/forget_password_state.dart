part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final ForgetPassowrdModel forgetPassowrdModel;
  const ForgetPasswordSuccess(this.forgetPassowrdModel);
}

final class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  const ForgetPasswordError(this.message);
}


// ** Reset Password ** //

final class ResetPasswordLoading extends ForgetPasswordState {}

final class ResetPasswordSuccess extends ForgetPasswordState {
  final PasswordResetModel passwordResetModel;
  const ResetPasswordSuccess(this.passwordResetModel);
}

final class ResetPasswordError extends ForgetPasswordState {
  final String message;
  const ResetPasswordError(this.message);
}