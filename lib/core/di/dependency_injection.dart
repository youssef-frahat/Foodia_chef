import 'package:foodia_chef/feature/auth/otp/data/repo/otp_user_repo.dart';
import 'package:foodia_chef/feature/auth/otp/data/repo/otp_user_repo_impl.dart';
import 'package:foodia_chef/feature/auth/otp/presentation/logic/cubit/otp_user_cubit.dart';
import 'package:foodia_chef/feature/home/all_order/data/repo/update_status_order_repo.dart';
import 'package:foodia_chef/feature/home/all_order/data/repo/update_status_order_repo_impl.dart';
import 'package:foodia_chef/feature/home/all_order/presentation/cubit/update_status_order_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  await _initExternals(); // تعديل هنا
  _initRepositories();
  _initCubits();
}

//? Externals
Future<void> _initExternals() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

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
    () => GetUserProfileRepoImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<OrderStatusRepository>(
        () => OrderStatusRepositoryImpl(getIt<ApiService>()),
  );
}

//? Cubits
void _initCubits() {
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginRepository>()),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterRepo>()),
  );

  getIt.registerFactory<OtpUserCubit>(
    () => OtpUserCubit(getIt<OtpUserRepo>()),
  );

  getIt.registerFactory<UserProfileCubit>(
    () => UserProfileCubit(getIt<GetUserProfileRepoImpl>()),
  );

  getIt.registerFactory<UpdateOrderStatusCubit>(
        () => UpdateOrderStatusCubit(getIt<OrderStatusRepository>()),
  );
}
