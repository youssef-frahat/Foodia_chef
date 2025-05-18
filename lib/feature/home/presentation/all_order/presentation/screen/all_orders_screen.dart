import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/core/di/dependency_injection.dart';
import 'package:foodia_chef/feature/home/presentation/all_order/presentation/screen/all_orders.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/update_status_order_cubit/update_status_order_cubit.dart';
import '../../../cubit/get_orders_cubit/get_orders_cubit.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<GetOrdersCubit>()..fetchOrders("pending"),
        ),
        BlocProvider(
          create: (context) => getIt<UpdateOrderStatusCubit>(),
        ),
      ],
      child: const AllOrders(),
    );
  }
}
