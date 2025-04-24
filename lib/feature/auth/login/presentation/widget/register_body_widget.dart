import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_config/app_colors.dart';
import '../../../../../core/app_config/app_images.dart';
import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/text_form_field/custom_text_form_field.dart';
import '../../../../../core/widgets/text_form_field/password_field.dart';

class RegisterBodyWidget extends StatefulWidget {
  const RegisterBodyWidget({super.key});

  @override
  State<RegisterBodyWidget> createState() => _RegisterBodyWidgetState();
}

class _RegisterBodyWidgetState extends State<RegisterBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourEmail;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourPhone;
    }
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validatePasswordMatch(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourPassword;
    }
    if (value != passwordController.text) {
      return AppStrings.passwordNotMatch;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: AppColors.buttonColor,
          onPressed: () => context.goNamed(Routes.login),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  AppImages.logo,
                  width: 186.w,
                  height: 186.h,
                ),
              ),
              20.height,
              Text(
                AppStrings.signup,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              40.height,
              CustomTextField(
                label: AppStrings.userName,
                controller: nameController,
                maxLines: 1,
                keyboardType: TextInputType.name,
                hint: AppStrings.enterUserName,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.pleaseEnterYourUserName;
                  }
                  return null;
                },
              ),
              12.height,
              CustomTextField(
                label: AppStrings.phone,
                controller: phoneController,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                hint: AppStrings.enterPhone,
                validator: _validatePhone,
              ),
              12.height,
              CustomTextField(
                label: AppStrings.email,
                controller: emailController,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                hint: AppStrings.enterEmail,
                validator: _validateEmail,
              ),
              12.height,
              PasswordField(
                label: AppStrings.password,
                controller: passwordController,
                hint: AppStrings.enterPassword,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.pleaseEnterYourPassword;
                  }
                  if (val.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              12.height,
              PasswordField(
                label: AppStrings.confirmPassword,
                controller: confirmPasswordController,
                hint: AppStrings.enterPassword,
                validator: _validatePasswordMatch,
              ),
              24.height,
              CustomButton(
                text: AppStrings.signup,
                backgroundColor: AppColors.buttonColor,
                radius: Radius.circular(50.r),
                height: 50.h,
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.goNamed(
                      Routes.register2Screen,
                    );
                  }
                },
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
