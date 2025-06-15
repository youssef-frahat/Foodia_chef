import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/app_config/app_colors.dart';
import 'package:foodia_chef/core/app_config/app_images.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';
import 'package:foodia_chef/core/helpers/messages.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:foodia_chef/core/widgets/text_form_field/custom_text_form_field.dart';
import 'package:foodia_chef/core/widgets/text_form_field/password_field.dart';
import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/register_cubit.dart';
import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/register_state.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/routes/routes.dart';

class RegisterBodyWidget extends StatefulWidget {
  const RegisterBodyWidget({super.key});

  @override
  State<RegisterBodyWidget> createState() => _RegisterBodyWidgetState();
}

class _RegisterBodyWidgetState extends State<RegisterBodyWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController bioController = TextEditingController();

  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return AppStrings.pleaseEnterYourEmail;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return AppStrings.pleaseEnterYourPhone;
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validatePasswordMatch(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.pleaseEnterYourPassword;
    }
    if (value != passwordController.text) return AppStrings.passwordNotMatch;
    return null;
  }

  String? _validateBio(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings
          .pleaseEnterYourBio; // رسالة التحذير إذا كانت السيرة الذاتية فارغة
    }
    return null;
  }

  String? _validateImage() {
    if (_selectedImage == null) {
      return "ضع صورة من فضلك"; // رسالة تحذير إذا لم يتم اختيار صورة
    }
    return null;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: BackButton(
          color: AppColors.buttonColor,
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt<RegisterCubit>(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              AppMessages.showLoading(context);
            }
            if (state is RegisterSuccess) {
              AppMessages.showSuccess(context, "تم التسجيل بنجاح");
              context.pushNamed(Routes.otpScreen,
                  extra: phoneController
                      .text); // Pass the OTP model to the next screen
            }
            if (state is RegisterError) {
              AppMessages.showError(context, state.error);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(AppImages.logo,
                            width: 186.w, height: 186.h),
                        20.height,
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor:
                                AppColors.buttonColor.withOpacity(0.2),
                            backgroundImage: _selectedImage != null
                                ? FileImage(File(_selectedImage!.path))
                                : null,
                            child: _selectedImage == null
                                ? Icon(Icons.camera_alt,
                                    size: 40.r, color: AppColors.buttonColor)
                                : null,
                          ),
                        ),
                        10.height,
                        Text(AppStrings.uploadProfilePicture,
                            style: TextStyle(
                                fontSize: 14.sp, color: AppColors.buttonColor)),
                      ],
                    ),
                  ),
                  30.height,
                  CustomTextField(
                    label: AppStrings.userName,
                    controller: nameController,
                    maxLines: 1,
                    keyboardType: TextInputType.name,
                    hint: AppStrings.enterUserName,
                    onChanged: (value) => setState(() {}),
                    validator: (val) => val == null || val.isEmpty
                        ? AppStrings.pleaseEnterYourUserName
                        : null,
                  ),
                  12.height,
                  CustomTextField(
                    label: AppStrings.phone,
                    controller: phoneController,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    hint: AppStrings.enterPhone,
                    onChanged: (value) => setState(() {}),
                    validator: _validatePhone,
                  ),
                  12.height,
                  CustomTextField(
                    label: AppStrings.email,
                    controller: emailController,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    hint: AppStrings.enterEmail,
                    onChanged: (value) => setState(() {}),
                    validator: _validateEmail,
                  ),
                  12.height,
                  PasswordField(
                    label: AppStrings.password,
                    controller: passwordController,
                    hint: AppStrings.enterPassword,
                    onChanged: (value) => setState(() {}),
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
                    onChanged: (value) => setState(() {}),
                    validator: _validatePasswordMatch,
                  ),
                  12.height,
                  CustomTextField(
                    label: AppStrings.bio,
                    controller: bioController,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    hint: AppStrings.enterBio,
                    onChanged: (value) => setState(() {}),
                    validator: _validateBio,
                  ),
                  24.height,
                  CustomButton(
                    text: AppStrings.signup,
                    backgroundColor: AppColors.buttonColor,
                    radius: Radius.circular(50.r),
                    height: 50.h,
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Validate image as well before proceeding
                        if (_validateImage() != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("ضع صوره من فضلك")),
                          );
                        } else {
                          context.read<RegisterCubit>().register(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                                bio: bioController.text,
                                image: _selectedImage,
                              );
                        }
                      }
                    },
                    textColor: Colors.white,
                  ),
                  20.height,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
