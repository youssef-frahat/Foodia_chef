import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import 'my_food/home/pages/eating/data/cubit/food_cubit.dart';
import 'my_food/home/pages/eating/presentaion/screen/eating.dart';

class MyFood extends StatelessWidget {
  const MyFood({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FoodCubit>()..fetchFoods(),
      child: const FoodScreen(),
    );
  }
}
