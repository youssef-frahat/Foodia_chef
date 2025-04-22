import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/helpers/shared_pref_local_storage.dart';
import 'package:foodia_chef/core/routes/routes.dart';

import 'core/routes/app_router.dart';

class Foodia extends StatelessWidget {
  final AppRouter appRouter;

  const Foodia({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 922),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: appRouter.router,
        title: 'Foodia Chef',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

checkLogin() async {
  final token = SharedPref.sharedPreferences.getString("token");
  if (token != null) {
    return AppRouter.appNavigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.home,
      (route) => false,
    );
  } else {
    return AppRouter.appNavigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }
}
