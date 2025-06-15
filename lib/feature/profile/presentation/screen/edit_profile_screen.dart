import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app_config/app_colors.dart';
import '../../../../core/app_config/app_strings.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/messages.dart';
import '../../../../core/widgets/buttons/custom_button.dart';
import '../../../../core/widgets/text_form_field/custom_text_form_field.dart';
import '../logic/cubit/user_profile_cubit.dart';
import '../widget/app_bar_edit.dart';
import '../widget/custome_upload_image.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone ;
  final String? image;
  final String? bio;

  const EditProfileScreen({
    super.key,
    required this.bio,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _bioController;

  XFile? selectedImage;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _phoneController = TextEditingController(text: widget.phone);
    _emailController = TextEditingController(text: widget.email);
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _bioController = TextEditingController(text: widget.bio ?? '');

    if (widget.image != null &&
        widget.image!.isNotEmpty &&
        File(widget.image!).existsSync()) {
      selectedImage = XFile(widget.image!);
    } else {
      selectedImage = null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: getIt<UserProfileCubit>(),
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state is EditeUserProfileError) {
              Navigator.of(context, rootNavigator: true).pop();
              AppMessages.showError(context, state.error);
            }
            if (state is EditeUserProfileSuccess) {
              Navigator.of(context, rootNavigator: true).pop();
              context.read<UserProfileCubit>().getUserProfile();
              AppMessages.showSuccess(context, AppStrings.editProfileSuccess);
              context.pop();
            }
            if (state is EditeUserProfileLoading) {
              AppMessages.showLoading(context);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      const AppBarEditProfile(),
                      25.height,
                      CustomUploadImage(
                        selectedImage: selectedImage != null
                            ? File(selectedImage!.path)
                            : null,
                        networkImage: widget.image,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text('الكاميرا'),
                                  onTap: () {
                                    _pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text('المعرض'),
                                  onTap: () {
                                    _pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      30.height,
                      CustomTextField(
                        hint: AppStrings.name,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppStrings.pleaseEnterYourName;
                          }
                          return null;
                        },
                      ),
                      20.height,
                      CustomTextField(
                        hint: AppStrings.phone,
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppStrings.pleaseEnterYourPhone;
                          }
                          if (value.length < 10) {
                            return 'يجب أن يتكون رقم الهاتف من 11 رقم';
                          }
                          return null;
                        },
                      ),
                      20.height,
                      CustomTextField(
                        hint: AppStrings.email,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppStrings.pleaseEnterYourEmail;
                          }
                          if (!value.contains('@')) {
                            return 'البريد الإلكتروني غير صالح';
                          }
                          return null;
                        },
                      ),
                      20.height,
                      CustomTextField(
                        hint: AppStrings.passwordNow,
                        obscure: true,
                        controller: _currentPasswordController,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length < 8) {
                            return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      20.height,
                      CustomTextField(
                        hint: AppStrings.newPassword,
                        obscure: true,
                        controller: _newPasswordController,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value.length < 8) {
                            return 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل';
                          }
                          return null;
                        },
                      ),
                      20.height,
                      CustomTextField(
                        hint: AppStrings.confirmPassword,
                        obscure: true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value != null &&
                              value.isNotEmpty &&
                              value != _newPasswordController.text) {
                            return 'كلمة المرور الجديدة غير متطابقة';
                          }
                          return null;
                        },
                      ),
                      20.height,
                      CustomTextField(
                        hint: AppStrings.bio,
                        obscure: false,
                        controller: _bioController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال وصف';
                          }
                          if (value.length < 10) {
                            return 'يجب أن يكون الوصف مكونًا من 10 حرفًا على الأقل';
                          }
                          return null;
                        },
                      ),
                      80.height,
                      CustomButton(
                        text: 'حفظ',
                        backgroundColor: AppColors.primaryColor,
                        height: 48.h,
                        radius: Radius.circular(50.r),
                        textColor: Colors.white,
                        onTap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<UserProfileCubit>().updateUserProfile(
                                  name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  email: _emailController.text.trim(),
                                  currentPassword:
                                      _currentPasswordController.text.trim(),
                                  password: _newPasswordController.text.trim(),
                                  passwordConfirmation:
                                      _confirmPasswordController.text.trim(),
                                  image: selectedImage,
                                  bio: _bioController.text.trim(),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image == null) return;

    setState(() {
      selectedImage = image;
    });

    log('Selected image path: ${selectedImage!.path}');
  }
}
