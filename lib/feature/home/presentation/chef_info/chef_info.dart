import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import '../../../../core/app_config/app_colors.dart';
import '../../../../core/app_config/app_images.dart';

class ChefInfo extends StatelessWidget {
  final String chefName;
  final String chefBio;
  final String chefImageUrl;
  final int ordersNum;
  final int followersNum;
  final int productsNum;

  const ChefInfo({
    super.key,
    required this.ordersNum,
    required this.productsNum,
    required this.followersNum,
    required this.chefName,
    required this.chefBio,
    required this.chefImageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Image.asset(AppImages.chef, fit: BoxFit.cover),
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
}
