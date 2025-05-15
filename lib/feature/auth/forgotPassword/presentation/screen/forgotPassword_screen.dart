import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/text_form_field/custom_text_form_field.dart';

import '../../../../../core/app_config/app_colors.dart';
import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/app_config/font_styles.dart';

class ForgotpasswordScreen extends StatelessWidget {
  const ForgotpasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              BackButton(),
              15.height,
              Text(AppStrings.forgotPasswordtex, style: FontStyles.body25W600),
              20.height,
              Image.asset('assets/images/forgotPassword.png'),
              30.height,
              Text(AppStrings.forgotPasswordBody, style: FontStyles.body14W500),
              50.height,
              CustomTextField(
                hint: AppStrings.phone,
                // controller: _phoneController,
                keyboardType: TextInputType.phone,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppStrings.pleaseEnterYourPhone;
                  }
                  if (value.length < 10) {
                    return 'رقم الهاتف يجب أن يكون 10 أرقام على الأقل';
                  }
                  return null;
                },
              ),
              80.height,
              Primarybutton(
                buttontext: AppStrings.sendCode,
                buttoncolor: AppColors.primarycolor,
                hight: 48.h,
                borderrediuse: 50.r,
                textcolor: Colors.white,
                onpress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
