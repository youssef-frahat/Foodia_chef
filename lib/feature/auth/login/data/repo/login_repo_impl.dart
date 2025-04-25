import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:foodia_chef/core/models/exceptions.dart';

import 'package:foodia_chef/feature/auth/login/data/model/auth_response_model/login/login_response_model.dart';

import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/app_config/app_urls.dart';
import '../../../../../core/app_config/prefs_keys.dart';
import '../../../../../core/helpers/connectivity_helper.dart';
import '../../../../../core/helpers/secure_local_storage.dart';
import '../../../../../core/models/failures.dart';
import '../../../../../core/network/api_services.dart';
import 'login_repo.dart';

class LoginRepositoryImpl extends LoginRepository {
  final ApiService apiService;

  LoginRepositoryImpl(this.apiService);
 @override
Future<Either<Failure, LoginResponseModel>> login({
  required String phone,
  required String password,
}) async {
  try {
    if (!await ConnectivityHelper.connected) {
      return const Left(NetworkFailure(AppStrings.checkInternetConnection));
    }

    final response = await apiService.post(
      AppUrls.login,
      data: {
        'phone': phone,
        'password': password,
      },
    );

    log('Login response: $response');

    if (response == null ||
        response['data'] == null ||
        response['data']['token'] == null) {
       return Left(AuthFailure(response['message']));
    }
    
    final String token = response['data']['token'];
    final LoginResponseModel user = LoginResponseModel.fromJson(response['data']);

    await SecureLocalStorage.write(PrefsKeys.token, token);
    await SecureLocalStorage.write(PrefsKeys.user, jsonEncode(response['data']));

    log(user.toJson().toString());
    return Right(user);
  } on NetworkException catch (e) {
    return Left(NetworkFailure(e.message));
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

}
