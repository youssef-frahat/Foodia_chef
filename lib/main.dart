import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/helpers/bloc_observer.dart';
import 'package:foodia_chef/core/helpers/shared_pref_local_storage.dart';
import 'package:foodia_chef/fodiaa.dart';
import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/register_cubit.dart';

import 'core/di/dependency_injection.dart';
import 'core/locale/locales.dart';
import 'core/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await SharedPref.init();

  Bloc.observer = MyBlocObserver();
  setupGetIt();

  runApp(
    EasyLocalization(
      startLocale: AppLocales.supportedLocales.first,
      supportedLocales: AppLocales.supportedLocales,
      fallbackLocale: AppLocales.supportedLocales.first,
      path: 'assets/translations',
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(getIt()), // استخدم getIt لتوفير RegisterApi
          ),
          // تقدر تضيف BlocProviders تانين هنا بنفس الطريقة
        ],
        child: Foodia(
          appRouter: AppRouter(),
        ),
      ),
    ),
  );
}
