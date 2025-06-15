import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/feature/home/presentation/chef_info/chef_info.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_chef/get_chef_cubit.dart';
import 'package:get_it/get_it.dart';

class ChefScreen extends StatelessWidget {
  const ChefScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ChefProfileCubit>()..getChefProfile(),
      child: ChefInfo(),
    );
  }
}
