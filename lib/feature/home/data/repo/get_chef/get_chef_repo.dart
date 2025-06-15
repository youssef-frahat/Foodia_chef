import 'package:dartz/dartz.dart';
import 'package:foodia_chef/core/models/failures.dart';

import '../../model/get_chef_model/get_chef_model.dart';

abstract class GetChefProfileRepo {
  Future<Either<Failure, GetChefProfileModel>> getChefProfile();
}
