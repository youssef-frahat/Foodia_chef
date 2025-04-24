

import 'package:dartz/dartz.dart';

import '../../../../../core/models/failures.dart';
import '../model/auth_response_model/login_response_model.dart';

abstract class LoginRepository{
   Future<Either<Failure, LoginResponseModel>> login({
    required String phone,
    required String password,
  });
}
