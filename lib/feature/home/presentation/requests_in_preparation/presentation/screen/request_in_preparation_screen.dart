import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/core/di/dependency_injection.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/update_status_order_cubit/update_status_order_cubit.dart';
import 'package:foodia_chef/feature/home/presentation/requests_in_preparation/presentation/screen/requestsIn_preparation.dart';

import '../../../cubit/get_orders_cubit/get_orders_cubit.dart';

class RequestsInPreparationScreen extends StatelessWidget {
  const RequestsInPreparationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GetOrdersCubit>()..fetchOrders("accept"),
        ),
        BlocProvider(
          create: (context) => getIt<UpdateOrderStatusCubit>(),
        ),
      ],
      child: const RequestsInPreparation(),
    );
  }
}
