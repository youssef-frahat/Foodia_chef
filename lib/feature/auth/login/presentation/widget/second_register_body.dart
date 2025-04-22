import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../core/app_config/app_colors.dart';
import '../../../../../core/app_config/app_images.dart';
import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/text_form_field/custom_text_form_field.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();
  File? _selectedImage; // To store the picked image file

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Disable default back button
        leading: BackButton(
            color: AppColors.buttonColor, // Set the color of the back button
            onPressed: () => context.goNamed(Routes.registerScreen)),

        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,

        elevation: 0, // Remove app bar shadow
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            Center(
              child: Column(
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
                  20.height,
                  // Profile Picture Section
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
            12.height,
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
