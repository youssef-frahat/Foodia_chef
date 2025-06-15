import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/otp_user_repo.dart'; // ✅ استيراد الواجهة بدلًا من الـ Impl

part 'otp_user_state.dart';

class OtpUserCubit extends Cubit<OtpUserState> {
  final OtpUserRepo otpUserRepo; // ✅ التغيير هنا لاستخدام الواجهة

  OtpUserCubit(this.otpUserRepo) : super(OtpUserInitial());

  Future<void> validateOtpCode({
    required String phoneNumber,
    required String otpCode,
  }) async {
    emit(ValidateOtpCodeLoading());
    try {
      final result = await otpUserRepo.verifyOtp(
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
      final result = await otpUserRepo.sendOtp(phoneNumber: phoneNumber);
      result.fold(
        (failure) {
          final errorMessage = failure.message.trim().isNotEmpty
              ? failure.message
              : 'حدث خطأ غير متوقع';
          emit(SendOtpCodeError(errorMessage));
        },
        (_) {
          emit(SendOtpCodeSuccess());
        },
      );
    } catch (e) {
      print('Error during sending OTP: $e');
      emit(SendOtpCodeError('خطأ غير متوقع: ${e.toString()}'));
    }
  }
}
