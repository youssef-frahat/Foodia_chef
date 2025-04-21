import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/order_card_widget.dart';


class AllOrderScreen extends StatelessWidget {
  const AllOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const OrderCardWidget();
      },
    );
  }
}

