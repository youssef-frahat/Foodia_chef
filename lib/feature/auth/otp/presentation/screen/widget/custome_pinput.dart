import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:ui' as ui;

import 'package:pinput/pinput.dart';

import '../../../../../../core/app_config/app_colors.dart';
import '../../../../../../core/app_config/font_styles.dart';

class CustomPinput extends StatelessWidget {
  final TextEditingController _otpController;
  final void Function(String)? onChanged; // ⬅️ أضف هذا السطر

  const CustomPinput({
    super.key,
    required TextEditingController otpController,
    this.onChanged,
  }) : _otpController = otpController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Pinput(
        length: 4,
        controller: _otpController,
        onChanged: onChanged,
        defaultPinTheme: PinTheme(
          height: 74.h,
          width: 74.w,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primarycolor),
            color: AppColors.secoundrycolor,
            borderRadius: BorderRadius.circular(8).r,
          ),
          textStyle: FontStyles.body15W400.copyWith(
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        focusedPinTheme: PinTheme(
          height: 74.h,
          width: 74.w,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primarycolor),
            color: AppColors.primarycolor,
            borderRadius: BorderRadius.circular(8).r,
          ),
          textStyle: TextStyle(
            color: AppColors.secoundrycolor,
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        preFilledWidget: Text(
          '0',
          style: TextStyle(color: AppColors.primarycolor, fontSize: 32.sp),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }
}
