import 'package:dartz/dartz.dart';

import '../../../../../core/models/failures.dart';
import '../model/forget_passowrd_model.dart';
import '../model/password_reset_model.dart';

abstract class ForgotPassowrdRepo {
  Future<Either<Failure, ForgetPassowrdModel>> forgetPassword({
    required String phone,
  });

   Future<Either<Failure, PasswordResetModel>> resetPassword({
    required String phone,
    required String password,
    required String conPassword,
  });
}
