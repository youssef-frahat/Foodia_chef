import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../core/app_config/app_colors.dart';
import '../../../../../core/app_config/app_images.dart';
import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/widgets/text_form_field/custom_text_form_field.dart';

class SecondPage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String passwordConfirmation;

  const SecondPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // لو كنت عايز تبعت OTP هنا:
    // context.read<RegisterCubit>().sendOtp(phone: widget.phone);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return BlocListener<RegisterCubit, RegisterState>(
    //   listener: (context, state) {
    //     if (state is RegisterLoading) {
    //       // ممكن تظهر لودر أو حاجة تانية لو حالة التحميل نشطة
    //     } else if (state is RegisterSuccess) {
    //       // الانتقال للصفحة التالية أو عرض رسالة النجاح
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(AppStrings.registrationSuccessful)),
    //       );
    //       context.pop(); // أو الانتقال لصفحة تانية
    //     } else if (state is RegisterError) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text("خطأ: ${state.error}")),
    //       );
    //     }
    //   },
    // child:
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: AppColors.buttonColor,
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: 186.w,
                    height: 186.h,
                  ),
                  20.height,
                  Text(
                    AppStrings.signup,
                    style: TextStyle(
                      fontFamily: 'Changa',
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  20.height,
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: AppColors.buttonColor.withOpacity(0.2),
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                      child: _selectedImage == null
                          ? Icon(Icons.camera_alt,
                              size: 40.r, color: AppColors.buttonColor)
                          : null,
                    ),
                  ),
                  10.height,
                  Text(
                    AppStrings.uploadProfilePicture,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
            ),
            40.height,
            CustomTextField(
              label: AppStrings.bio,
              controller: _bioController,
              maxLines: 5,
              keyboardType: TextInputType.text,
              hint: AppStrings.enterBio,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return AppStrings.pleaseEnterYourBio;
                }
                return null;
              },
            ),
            20.height,
            CustomButton(
              text: AppStrings.signup,
              backgroundColor: AppColors.buttonColor,
              radius: Radius.circular(50.r),
              height: 50.h,
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {}
              },
              textColor: Colors.white,
            ),
            20.height,
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }
}
