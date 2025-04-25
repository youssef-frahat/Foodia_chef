import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import '../../../../../core/app_config/app_colors.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _otpCode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: ListView(
            children: [
              100.height,
              Center(
                child: SvgPicture.asset(
                  'assets/images/otp2.svg',
                  width: 332,
                  height: 249,
                  fit: BoxFit.cover,
                ),
              ),
              24.height,
              Text(
                textAlign: TextAlign.center,
                AppStrings.enterotpcode,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              20.height,
              Text(
                AppStrings.wesendyourcode,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              20.height,
              OtpTextField(
                borderRadius: BorderRadius.circular(200.r),
                focusedBorderColor: AppColors.primaryColor,
                enabledBorderColor: AppColors.borderColor,
                autoFocus: false,
                fieldWidth: 60.w,
                numberOfFields: 4,
                borderColor: AppColors.borderColor,
                showFieldAsBox: true,
                onCodeChanged: (String code) {
                  setState(() {
                    _otpCode = code;
                  });
                },
                onSubmit: (String code) {},
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.idontresve),
                  5.width,
                  InkWell(
                    onTap: () {},
                    child: Text(
                      AppStrings.resend,
                      style: TextStyle(
                        color: AppColors.buttonColor,
                        fontSize: 14.sp,
                        fontFamily: 'Changa',
                      ),
                    ),
                  ),
                ],
              ),
              20.height,
              CustomButton(
                  width: 100.w,
                  height: 48,
                  radius: Radius.circular(10),
                  text: AppStrings.confirm,
                  textColor: Colors.white,
                  backgroundColor: AppColors.buttonColor,
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
