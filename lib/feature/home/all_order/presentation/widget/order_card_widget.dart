import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';

import '../../../../../core/app_config/app_colors.dart';
import '../../../../../core/app_config/app_icons.dart';
import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/app_config/font_styles.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            // First row: User info and total price
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.0.w),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.frame),
                  10.width,
                  Text('كريم علي', style: FontStyles.textStyle14),
                  Spacer(),
                  Column(
                    children: [
                      Text("الاجمالي", style: FontStyles.textStyle14),
                      5.height,
                      Text(
                        '145 ج.م',
                        style: FontStyles.textStyle14
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Second row: Item image, name, quantity, and price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Color(0xFFF8A435),
                    backgroundImage: NetworkImage(
                      "https://cdn.supermama.me/Recipe/88305/1507578229/web-watermarked-large/%D8%B5%D9%88%D8%B1%D8%A9-%D8%A8%D8%B9%D9%86%D9%88%D8%A7%D9%86-%D8%B5%D9%8A%D9%86%D9%8A%D8%A9-%D9%85%D9%83%D8%B1%D9%88%D9%86%D8%A9-%D8%A8%D8%A7%D9%84%D8%AF%D8%AC%D8%A7%D8%AC-%D9%81%D9%8A-%D8%A7%D9%84%D9%81%D8%B1%D9%86.webp",
                    ),
                  ),
                  10.width,
                  Text(
                    'مكرونة فرن بالدجاج',
                    style: FontStyles.textStyle14,
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        "الكمية",
                        style: FontStyles.textStyle14.copyWith(fontSize: 18.sp),
                      ),
                      5.height,
                      Text(
                        '1',
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
                        style: FontStyles.textStyle14.copyWith(fontSize: 18.sp),
                      ),
                      5.height,
                      Text(
                        '145 ج.م',
                        textAlign: TextAlign.center,
                        style: FontStyles.textStyle14
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 10.height,
            Divider(
              color: Colors.grey,
              thickness: 2.h,
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.h),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomElevationButton(
                    title: AppStrings.accpted,
                    onPressed: () {},
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    fontSize: 16.0.sp,
                    elevation: 5.0,
                    borderRadius: 20.0,
                    width: 140.w,
                  ),
                   CustomElevationButton(
                    title: AppStrings.rejected,
                    onPressed: () {},
                    backgroundColor: Color(0xFF5F4B46),
                    textColor: Colors.white,
                    fontSize: 16.0.sp,
                    elevation: 5.0,
                    borderRadius: 20.0,
                    width: 140.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
