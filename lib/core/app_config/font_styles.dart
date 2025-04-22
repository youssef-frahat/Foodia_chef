import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class FontStyles {
  static final textStyle12 = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Changa',
    fontWeight: FontWeight.w300,
    color: AppColors.hintColor,
  );
  static final textStyle14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Color(0xFFF8A435),
    fontFamily: 'Changa',
  );
  static final textStyle16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textformColor,
    fontFamily: 'Changa',
  );
  static final textStyle18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Changa',
  );
  static final textStyle20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Changa',
  );
  static final textStyle24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: 'Changa',
  );
  static final textStyle28 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w500,
    fontFamily: 'Changa',
  );

  static const fontFamily = 'Changa';
  static final label24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static final label16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static final headline16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static final headline14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static final body14W700 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );
  static final body14W500 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );
  static final body12W400 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );
}
