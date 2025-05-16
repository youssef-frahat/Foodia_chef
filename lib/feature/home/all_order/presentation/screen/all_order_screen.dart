import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/di/dependency_injection.dart';

import '../widget/order_card_widget.dart';

import '../cubit/update_status_order_cubit.dart';

class AllOrderScreen extends StatelessWidget {
  const AllOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UpdateOrderStatusCubit>(),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
        itemCount: 10,
        itemBuilder: (context, index) {
          return OrderCardWidget();
        },
      ),
    );
  }
}
