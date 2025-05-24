import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_chef_info_cubit/get_chef_cubit.dart';
import '../../../../core/app_config/app_colors.dart';
import '../../../../core/app_config/app_images.dart';
import '../../../../core/helpers/messages.dart';
import '../cubit/get_chef_info_cubit/get_chef_state.dart';

class ChefInfo extends StatelessWidget {
  ChefInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChefCubit, ChefState>(
      listener: (context, state) {
        if (state is ChefError) {
          AppMessages.showError(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is ChefLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChefError) {
          return Center(child: Text(state.message));
        } else if (state is ChefLoaded) {
          final chef = state.chef;
          final statistics = state.statistics;

          // Extract needed data from chef and statistics safely
          final chefImageUrl = chef.image ?? '';
          final ordersNum = statistics.totalDishes ?? 0;
          final productsNum = statistics.totalCompletedOrders ?? 0;
          final followersNum = statistics.totalFollowers ?? 0;
          final chefName = chef.name ?? '';
          final chefBio = chef.bio ?? '';

          return Container(
            width: 421.w,
            height: 240.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 89.03.w,
                          height: 90.87.h,
                          child: CircleAvatar(
                            radius: 70.r,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: chefImageUrl,
                                fit: BoxFit.cover,
                                width: 89.03.w,
                                height: 90.87.h,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(AppImages.chef,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        80.width,
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("عدد الطلبات    $ordersNum",
                                  style: TextStyle(
                                    fontFamily: 'Changa',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightBGColor,
                                  )),
                              8.height,
                              Text("عدد المنتجات    $productsNum",
                                  style: TextStyle(
                                    fontFamily: 'Changa',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightBGColor,
                                  )),
                              8.height,
                              Text("عدد المتابعين    $followersNum",
                                  style: TextStyle(
                                    fontFamily: 'Changa',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lightBGColor,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 15.w, top: 0.h),
                    child: Text(
                      chefName,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 15.w, top: 5.h),
                    child: Text(
                      chefBio,
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightBGColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Fallback empty container if none of the states matched (optional)
        return const SizedBox.shrink();
      },
    );
  }
}
