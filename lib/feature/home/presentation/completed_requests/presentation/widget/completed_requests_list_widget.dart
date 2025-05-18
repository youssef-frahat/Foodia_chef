import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import '../../../../../../core/app_config/app_strings.dart';
import '../../../../../../core/app_config/font_styles.dart';

class CompletedRequestsListWidget extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;
  const CompletedRequestsListWidget({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Color(0xFFF8A435),
                backgroundImage: NetworkImage('${AppStrings.baseUrl}$imageUrl'),
              ),
              10.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: FontStyles.textStyle14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.height,
                    Text(
                      '$price ج.م',
                      style: FontStyles.textStyle14.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 15.sp,
              ),
              10.width,
              Text(
                AppStrings.completed,
                style: FontStyles.textStyle14.copyWith(
                    color: Colors.green,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
