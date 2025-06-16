import 'package:foodia_chef/feature/auth/otp/data/repo/otp_user_repo.dart';
import 'package:foodia_chef/feature/auth/otp/data/repo/otp_user_repo_impl.dart';
import 'package:foodia_chef/feature/auth/otp/presentation/logic/cubit/otp_user_cubit.dart';

import 'package:foodia_chef/feature/auth/login/data/repo/login_repo.dart';
import 'package:foodia_chef/feature/auth/login/data/repo/login_repo_impl.dart';
import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/login_cubit.dart';

import 'package:foodia_chef/feature/auth/login/data/repo/register_repo.dart';
import 'package:foodia_chef/feature/auth/login/data/repo/register_repo_impl.dart';
import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/register_cubit.dart';

import 'package:foodia_chef/feature/home/data/repo/get_orders/get_orders_repo.dart';
import 'package:foodia_chef/feature/home/data/repo/get_orders/get_orders_repo_impl.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_orders_cubit/get_orders_cubit.dart';

import 'package:foodia_chef/feature/home/data/repo/update_status_order/update_status_order_repo.dart';
import 'package:foodia_chef/feature/home/data/repo/update_status_order/update_status_order_repo_impl.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/update_status_order_cubit/update_status_order_cubit.dart';

import 'package:foodia_chef/feature/profile/data/repo/get_user_profile_repo_impl.dart';
import 'package:foodia_chef/feature/profile/presentation/logic/cubit/user_profile_cubit.dart';

import 'package:foodia_chef/core/network/api_services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/forgotPassword/data/repo/forgot_passowrd_repo_impl.dart';
import '../../feature/auth/forgotPassword/presentation/logic/forgetPassword/cubit/forget_password_cubit.dart';
import '../../feature/home/data/repo/get_chef/get_chef_repo.dart';
import '../../feature/home/data/repo/get_chef/get_chef_repo_imol.dart';
import '../../feature/home/presentation/cubit/get_chef/get_chef_cubit.dart';
import '../../feature/home/presentation/my_food/home/pages/eating/data/cubit/food_cubit.dart';
import '../../feature/home/presentation/my_food/home/pages/eating/data/repo/add_food_repo.dart';
import '../../feature/wallet/data/repo/withdraw_repo.dart';
import '../../feature/wallet/data/repo/withdraw_repo_impl.dart';
import '../../feature/wallet/presentation/logic/cubit/Withdraw_Cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  await _initExternals();
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

  getIt.registerLazySingleton<GetOrdersRepo>(
    () => GetOrdersRepoImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<GetChefProfileRepo>(
    () => GetChefProfileRepoImpl(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton<ForgotPassowrdRepoImpl>(
    () => ForgotPassowrdRepoImpl(getIt()),
  );

  getIt.registerLazySingleton<WithdrawRepo>(
    () => WithdrawRepoImpl(getIt<ApiService>()),
  );
    getIt.registerLazySingleton<FoodRepository>(
    () => FoodRepository(getIt<ApiService>()),
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

  getIt.registerFactory<GetOrdersCubit>(
    () => GetOrdersCubit(getIt<GetOrdersRepo>()),
  );

  getIt.registerFactory<ChefProfileCubit>(
    () => ChefProfileCubit(getIt<GetChefProfileRepo>()),
  );

  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(getIt()),
  );

  getIt.registerFactory<WithdrawCubit>(
    () => WithdrawCubit(getIt<WithdrawRepo>()),
  );
    getIt.registerFactory<FoodCubit>(
    () => FoodCubit(getIt<FoodRepository>()),
  );

}
