import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/app_config/app_urls.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/app_config/app_colors.dart';
import 'package:foodia_chef/core/app_config/app_images.dart';

import '../cubit/get_chef/get_chef_cubit.dart';
import '../cubit/get_chef/get_chef_state.dart';

class ChefInfo extends StatelessWidget {
  const ChefInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChefProfileCubit, ChefProfileState>(
      builder: (context, state) {
        if (state is ChefProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChefProfileLoaded) {
          final chef = state.profile.chef;
          final stats = state.profile.chefStatistics;

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
                                imageUrl: "${AppUrls.baseImage}${chef.image}",
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
                              Text("عدد الطلبات    ${chef.totalOrder}",
                                  style: _infoStyle()),
                              8.height,
                              Text("عدد المنتجات    ${stats.totalDishes}",
                                  style: _infoStyle()),
                              8.height,
                              Text("عدد المتابعين    ${stats.totalFollowers}",
                                  style: _infoStyle()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 15.w, top: 0.h),
                    child: Text(
                      chef.name,
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
                      chef.bio,
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
        } else if (state is ChefProfileError) {
          return Center(
              child: Text(state.message, style: TextStyle(color: Colors.red)));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  TextStyle _infoStyle() {
    return TextStyle(
      fontFamily: 'Changa',
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.lightBGColor,
    );
  }
}
