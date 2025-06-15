import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/core/di/dependency_injection.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_orders_cubit/get_orders_cubit.dart';
import 'canceled_requests.dart';

class CanceledRequestsScreen extends StatelessWidget {
  const CanceledRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetOrdersCubit>()..fetchOrders("reject"),
      child: const CanceledRequests(),
    );
  }
}
