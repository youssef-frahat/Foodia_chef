import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/otp_user_repo_impl.dart';

part 'otp_user_state.dart';

class OtpUserCubit extends Cubit<OtpUserState> {
  final OtpUserRepoImpl otpUserRepoImpl;
  OtpUserCubit(this.otpUserRepoImpl) : super(OtpUserInitial());

  Future<void> validateOtpCode({
    required String phoneNumber,
    required String otpCode,
  }) async {
    emit(ValidateOtpCodeLoading());
    try {
      final result = await otpUserRepoImpl.verifyOtp(
        phoneNumber: phoneNumber,
        otpCode: otpCode,
      );
      result.fold(
        (failure) {
          final errorMessage = failure.message.trim().isNotEmpty
              ? failure.message
              : 'حدث خطأ غير متوقع';
          emit(ValidateOtpCodeError(errorMessage));
        },
        (_) {
          emit(ValidateOtpCodeSuccess());
          // Optional: Reset state
          // Future.delayed(Duration.zero, () => emit(OtpUserInitial()));
        },
      );
    } catch (e) {
      print('Error during OTP validation: $e');
      emit(ValidateOtpCodeError('خطأ غير متوقع: ${e.toString()}'));
    }
  }

  Future<void> sendOtpCode({required String phoneNumber}) async {
    emit(SendOtpCodeLoading());
    try {
      final result = await otpUserRepoImpl.sendOtp(phoneNumber: phoneNumber);
      result.fold(
        (failure) {
          final errorMessage = failure.message.trim().isNotEmpty
              ? failure.message
              : 'حدث خطأ غير متوقع';
          emit(SendOtpCodeError(errorMessage));
        },
        (_) {
          emit(SendOtpCodeSuccess());
          // Optional: Reset state
          // Future.delayed(Duration.zero, () => emit(OtpUserInitial()));
        },
      );
    } catch (e) {
      print('Error during sending OTP: $e');
      emit(SendOtpCodeError('خطأ غير متوقع: ${e.toString()}'));
    }
  }
}
