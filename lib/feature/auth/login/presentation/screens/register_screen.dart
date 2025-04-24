import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/register_api_services.dart';
import '../cubit/cubit/register_cubit.dart';
import '../widget/register_body_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(RegisterApi()),
        child: RegisterBodyWidget());
  }
}
