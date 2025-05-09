import 'package:foodia_chef/feature/auth/otp/data/repo/otp_user_repo.dart';
import 'package:foodia_chef/feature/auth/otp/data/repo/otp_user_repo_impl.dart';
import 'package:foodia_chef/feature/auth/otp/presentation/logic/cubit/otp_user_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../feature/auth/login/data/repo/login_repo.dart';
import '../../feature/auth/login/data/repo/login_repo_impl.dart';
import '../../feature/auth/login/presentation/cubit/cubit/login_cubit.dart';

import '../../feature/auth/login/data/repo/register_repo.dart';
import '../../feature/auth/login/data/repo/register_repo_impl.dart';
import '../../feature/auth/login/presentation/cubit/cubit/register_cubit.dart';

import '../../feature/profile/data/repo/get_user_profile_repo_impl.dart';
import '../../feature/profile/presentation/logic/cubit/user_profile_cubit.dart';
import '../network/api_services.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  _initExternals();
  _initRepositories();
  _initCubits();
}

//? Externals
void _initExternals() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
}

//? Repositories
void _initRepositories() {
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepositoryImpl(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<OtpUserRepo>(
    () => OtpUserRepoImpl(getIt<ApiService>()),
  );
   getIt.registerLazySingleton<GetUserProfileRepoImpl>(
    () => GetUserProfileRepoImpl(getIt()),
  );
}

void _initCubits() {
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginRepository>()),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterRepo>()),
  );
  getIt.registerFactory<OtpUserCubit>(() => OtpUserCubit(getIt()));
  getIt.registerFactory<UserProfileCubit>(() => UserProfileCubit(getIt()));
}
