// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foodia_chef/core/extensions/space_extension.dart';
// import 'package:foodia_chef/core/routes/routes.dart';
// import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
// import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/register_cubit.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import '../../../../../core/app_config/app_colors.dart';
// import '../../../../../core/app_config/app_images.dart';
// import '../../../../../core/app_config/app_strings.dart';
// import '../../../../../core/widgets/text_form_field/custom_text_form_field.dart';

// class SecondPage extends StatefulWidget {
//   const SecondPage({super.key, });

//   @override
//   State<SecondPage> createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _bioController = TextEditingController();
//   XFile? _selectedImage; // Use XFile instead of File

//   @override
//   void initState() {
//     super.initState();
//     // If you need to handle OTP, add that functionality here.
//   }

//   // Updated _pickImage function to return XFile instead of File
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final XFile? pickedFile =
//         await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = pickedFile; // Store the XFile
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Safely access the passed data
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         leading: BackButton(
//           color: AppColors.buttonColor,
//           onPressed: () => context.pop(),
//         ),
//         backgroundColor: Colors.transparent,
//         scrolledUnderElevation: 0,
//         elevation: 0,
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: EdgeInsets.symmetric(horizontal: 16.w),
//           children: [
//             Center(
//               child: Column(
//                 children: [
//                   Image.asset(
//                     AppImages.logo,
//                     width: 186.w,
//                     height: 186.h,
//                   ),
//                   20.height,
//                   Text(
//                     AppStrings.signup,
//                     style: TextStyle(
//                       fontFamily: 'Changa',
//                       fontSize: 28.sp,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.black,
//                     ),
//                   ),
//                   20.height,
//                   GestureDetector(
//                     onTap: _pickImage,
//                     child: CircleAvatar(
//                       radius: 60.r,
//                       backgroundColor: AppColors.buttonColor.withOpacity(0.2),
//                       backgroundImage: _selectedImage != null
//                           ? FileImage(File(_selectedImage!
//                               .path)) // Convert XFile to File for displaying
//                           : null,
//                       child: _selectedImage == null
//                           ? Icon(Icons.camera_alt,
//                               size: 40.r, color: AppColors.buttonColor)
//                           : null,
//                     ),
//                   ),
//                   10.height,
//                   Text(
//                     AppStrings.uploadProfilePicture,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       color: AppColors.buttonColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             40.height,
//             CustomTextField(
//               label: AppStrings.bio,
//               controller: _bioController,
//               maxLines: 5,
//               keyboardType: TextInputType.text,
//               hint: AppStrings.enterBio,
//               validator: (val) {
//                 if (val == null || val.isEmpty) {
//                   return AppStrings.pleaseEnterYourBio;
//                 }
//                 return null;
//               },
//             ),
//             20.height,
//             CustomButton(
//               text: AppStrings.signup,
//               backgroundColor: AppColors.buttonColor,
//               radius: Radius.circular(50.r),
//               height: 50.h,
//               onTap: () {
//                 if (_formKey.currentState?.validate() ?? false) {
//                   context.read<RegisterCubit>().register(
//                         phone: phone,
//                         password: password,
//                         name: name,
//                         email: email,
//                         bio: _bioController.text,
//                         image: _selectedImage, // Pass XFile here
//                         confirmPassword: confirmPassword,
//                       );
//                   context.push(Routes.otpScreen);
//                 } else {
//                   // Handle the case where the image is not selected
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("ضع صوره من فضلك")),
//                   );
//                 }
//               },
//               textColor: Colors.white,
//             ),
//             20.height,
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _bioController.dispose();
//     super.dispose();
//   }
// }
