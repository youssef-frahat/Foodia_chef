import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/app_config/app_colors.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:foodia_chef/feature/auth/presentation/widget/signup_prompt_row.dart';

import '../../../../core/app_config/app_images.dart';
import '../../../../core/widgets/text_form_field/custom_text_form_field.dart';
import '../../../../core/widgets/text_form_field/password_field.dart';
import 'remember_me_row.dart';

class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      child: ListView(
        children: [
          Center(
            child: Image.asset(
              AppImages.logo,
              width: 186.w,
              height: 186.h,
            ),
          ),
          Text(
            AppStrings.login,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          73.height,
          CustomTextField(
            label: AppStrings.phone,
            hint: AppStrings.enterPhone,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return AppStrings.pleaseEnterYourPhone;
              }
              return null;
            },
          ),
          12.height,
          PasswordField(
            label: AppStrings.password,
            hint: AppStrings.enterPassword,
            validator: (password) {
              if (password == null || password.isEmpty) {
                return AppStrings.pleaseEnterYourPassword;
              }
              return null;
            },
          ),
          12.height,
          RememberMeRow(),
          12.height,
          CustomButton(
            text: AppStrings.login1,
            backgroundColor: AppColors.buttonColor,
            radius: Radius.circular(50.r),
            height: 50.h,
            onTap: () {
              // login action
            },
          ),
          60.height,
          SignupPromptRow(
               onSignupTap: () {
                 // Navigate to signup page
               },
          ),
          135.height,
        ],
      ),
    );
  }
}
