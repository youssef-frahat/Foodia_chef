import 'package:dartz/dartz.dart';
import 'package:foodia_chef/feature/auth/login/data/model/auth_response_model/register/register_response_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/models/failures.dart';

abstract class RegisterRepo {
  Future<Either<Failure, RegisterResponseModel>> register({
    required String phone,
    required String password,
    required String passwordConfirmation,
    required String name,
    required String email,
    required String bio,
    required XFile image,
  });
}
