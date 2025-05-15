import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../model/otp_response_model.dart';

abstract class OtpUserRepo {
  Future<Either<Failure, OtpResponseModel>> sendOtp({
    required String phoneNumber,
  });

  //! Sends an OTP code to the user's phone number.
  Future<Either<Failure, OtpResponseModel>> verifyOtp({
    required String phoneNumber,
    required String otpCode,
  });
}
