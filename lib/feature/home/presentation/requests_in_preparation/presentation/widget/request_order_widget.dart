import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/update_status_order_cubit/update_status_order_cubit.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_orders_cubit/get_orders_cubit.dart';

import '../../../../../../core/app_config/app_icons.dart';
import '../../../../../../core/app_config/app_strings.dart';
import '../../../../../../core/app_config/font_styles.dart';

class RequestOrderWidget extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;
  final int qty;
  final String userName;
  final int orderId;

  const RequestOrderWidget({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.qty,
    required this.userName,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateOrderStatusCubit, UpdateOrderStatusState>(
      listener: (context, state) {
        if (state is UpdateOrderStatusSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.response.message)),
          );
          // إعادة تحميل الطلبات
          context.read<GetOrdersCubit>().fetchOrders("accept");
        } else if (state is UpdateOrderStatusError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: SizedBox(
        height: 250.h,
        child: Container(
          margin: EdgeInsets.only(bottom: 16.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Color(0xFFF8F8F8),
            border: Border.all(
              color: Color(0xFFF8A435),
              width: 2.w,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.0.w),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.frame),
                    10.width,
                    Text(userName, style: FontStyles.textStyle14),
                    Spacer(),
                    Column(
                      children: [
                        Text("الاجمالي", style: FontStyles.textStyle14),
                        5.height,
                        Text(
                          '${(double.parse(price) * qty).toStringAsFixed(2)} ج.م',
                          style: FontStyles.textStyle14
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Color(0xFFF8A435),
                      backgroundImage:
                          NetworkImage('${AppStrings.baseUrl}$imageUrl'),
                    ),
                    10.width,
                    Expanded(
                      child: Text(
                        name,
                        style: FontStyles.textStyle14,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          "الكمية",
                          style:
                              FontStyles.textStyle14.copyWith(fontSize: 18.sp),
                        ),
                        5.height,
                        Text(
                          '$qty',
                          textAlign: TextAlign.center,
                          style: FontStyles.textStyle14
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    15.width,
                    Column(
                      children: [
                        Text(
                          "السعر",
                          style:
                              FontStyles.textStyle14.copyWith(fontSize: 18.sp),
                        ),
                        5.height,
                        Text(
                          '$price ج.م',
                          textAlign: TextAlign.center,
                          style: FontStyles.textStyle14
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 2.h,
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevationButton(
                      title: AppStrings.prepared,
                      onPressed: () {
                        context
                            .read<UpdateOrderStatusCubit>()
                            .updateOrderStatus(
                              orderId: orderId,
                              status: 'complete',
                            );
                      },
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                      fontSize: 16.0.sp,
                      elevation: 5.0,
                      borderRadius: 20.0,
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 30.w,
                      ),
                      width: 300.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
