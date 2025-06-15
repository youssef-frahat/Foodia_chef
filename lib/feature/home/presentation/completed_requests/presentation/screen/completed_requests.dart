import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_orders_cubit/get_orders_cubit.dart';

import '../widget/completed_requests_list_widget.dart';

class CompletedRequests extends StatelessWidget {
  const CompletedRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrdersCubit, GetOrdersState>(
      builder: (context, state) {
        if (state is GetOrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetOrdersFailure) {
          return Center(child: Text("خطأ: ${state.error}"));
        } else if (state is GetOrdersSuccess) {
          final orders = state.orders.orderItems;
          if (orders.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد طلبات مكتملة حالياً',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final item = orders[index];
              return CompletedRequestsListWidget(
                name: item.food.name,
                price: item.subtotal,
                imageUrl: item.food.image,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
