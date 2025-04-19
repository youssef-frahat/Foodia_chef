import 'package:get_it/get_it.dart';
import '../../feature/auth/login/data/repo/login_repo.dart';
import '../../feature/auth/login/data/repo/login_repo_impl.dart';
import '../../feature/auth/login/presentation/cubit/cubit/login_cubit.dart';
import '../network/api_services.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  _initExternals();
  _initRepositories();
  _initCubits();
}

//?Externals
void _initExternals() {
  getIt.registerLazySingleton<ApiService>(() => ApiService());
 
}

//?Repositories
void _initRepositories() {
  // getIt.registerLazySingleton<RegisterRepository>(
  //   () => RegisterRepositoryImpl(
  //     getIt(),
  //   ),
  // );
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      getIt(),

    ),
  );
 
 
}

//?Blocs

void _initCubits() {
 
  // getIt.registerFactory<RegisterCubit>(
  //   () => RegisterCubit(
  //     getIt(),
  //   ),
  // );
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      getIt(),
    ),
  );
  
}
