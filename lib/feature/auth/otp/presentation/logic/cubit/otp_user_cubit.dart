import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/otp_user_repo.dart'; // استخدم الواجهة وليس التنفيذ

part 'otp_user_state.dart';

class OtpUserCubit extends Cubit<OtpUserState> {
  final OtpUserRepo otpUserRepo;

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
          emit(ValidateOtpCodeError(failure.message));
        },
        (_) {
          emit(ValidateOtpCodeSuccess());
        },
      );
    } catch (e) {
      emit(ValidateOtpCodeError('An unexpected error occurred: $e'));
    }
  }

  Future<void> sendOtpCode({required String phoneNumber}) async {
    emit(SendOtpCodeLoading());
    try {
      final result = await otpUserRepo.sendOtp(phoneNumber: phoneNumber);
      result.fold(
        (failure) {
          emit(SendOtpCodeError(failure.message));
        },
        (_) {
          emit(SendOtpCodeSuccess());
        },
      );
    } catch (e) {
      emit(SendOtpCodeError('An unexpected error occurred: $e'));
    }
  }
}
