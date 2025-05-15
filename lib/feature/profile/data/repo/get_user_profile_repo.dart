import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failures.dart';
import '../model/edit_user_profile_model/edit_user_profile_model.dart';
import '../model/get_user_profile_model/get_user_profile_model.dart';

abstract class GetUserProfileRepo {
  Future<Either<Failure, GetUserProfileModel>> getUserProfile();
  Future<Either<Failure, EditUserProfileModel>> updateUserProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
    String? passwordConfirmation,
    String? currentPassword,
    required XFile? image,
  });
  Future<Either<Failure, Unit>> logout();
}
