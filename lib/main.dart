import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/helpers/bloc_observer.dart';
import 'package:foodia_chef/fodiaa.dart';

import 'core/di/dependency_injection.dart';
import 'core/routes/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  
  Bloc.observer = MyBlocObserver();
  setupGetIt();
  runApp( Foodia(  appRouter: AppRouter(),));
}
