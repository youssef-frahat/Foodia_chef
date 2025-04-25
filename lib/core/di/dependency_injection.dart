import 'package:get_it/get_it.dart';

import '../../feature/auth/login/data/repo/login_repo.dart';
import '../../feature/auth/login/data/repo/login_repo_impl.dart';
import '../../feature/auth/login/presentation/cubit/cubit/login_cubit.dart';

import '../../feature/auth/login/data/repo/register_repo.dart';
import '../../feature/auth/login/data/repo/register_repo_impl.dart';
import '../../feature/auth/login/presentation/cubit/cubit/register_cubit.dart';

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
}

//? Cubits
void _initCubits() {
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<LoginRepository>()),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<RegisterRepo>()),
  );
}
