import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/register_cubit.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../widget/register_body_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<RegisterCubit>(),
        child: RegisterBodyWidget(),
      ),
    );
  }
}
