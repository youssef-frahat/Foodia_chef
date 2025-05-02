import 'package:dartz/dartz.dart';

import '../../../../../core/models/failures.dart';

abstract class OtpUserRepo {

  Future<Either<Failure, Unit>> sendOtp({
    required String phoneNumber,
  });

  //! Sends an OTP code to the user's phone number.
  Future<Either<Failure,Unit >> verifyOtp({
    required String phoneNumber,
    required String otpCode,
  });
}