import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/core/di/dependency_injection.dart';
import 'package:foodia_chef/feature/home/presentation/completed_requests/presentation/screen/completed_requests.dart';

import '../../../cubit/get_orders_cubit/get_orders_cubit.dart';

class CompletedRequestsScreen extends StatelessWidget {
  const CompletedRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GetOrdersCubit>()..fetchOrders("complete"),
      child: const CompletedRequests(),
    );
  }
}
