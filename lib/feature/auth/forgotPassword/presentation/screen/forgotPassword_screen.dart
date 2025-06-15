import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_config/app_colors.dart';
import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/app_config/font_styles.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/helpers/messages.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/text_form_field/my_text_form_faield.dart';
import '../logic/forgetPassword/cubit/forget_password_cubit.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
      ),
      body: BlocProvider(
        create: (context) => getIt<ForgetPasswordCubit>(),
        child: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (!context.mounted) return;

                if (state is ForgetPasswordSuccess) {
                  setState(() {
                    isProcessing = false;
                  });
                  context.goNamed(
                    Routes.forgotPasswordOtp,
                    extra: _phoneController.text.trim(),
                  );
                } else if (state is ForgetPasswordError) {
                  setState(() {
                    isProcessing = false;
                  });
                  AppMessages.showError(context, state.message);
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      15.height,
                      Text(
                        AppStrings.forgotPasswordtex,
                        style: FontStyles.body25W600,
                      ),
                      20.height,
                      Image.asset('assets/images/forgotPassword.png'),
                    30.height,
                      Text(
                        AppStrings.forgotPasswordBody,
                        style: FontStyles.body14W500,
                      ),
                      50.height,
                      MyTextFormField(
                        hintText: AppStrings.phone,
                        controller: _phoneController,
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
                      (state is ForgetPasswordLoading || isProcessing)
                          ? const CircularProgressIndicator()
                          : CustomButton(

                              text: AppStrings.sendCode,
                              backgroundColor: AppColors.buttonColor,
                              height: 48.h,
                              radius: Radius.circular(50.r),
                              textColor: Colors.white,
                              onTap: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  context
                                      .read<ForgetPasswordCubit>()
                                      .forgetPassword(
                                        phone: _phoneController.text.trim(),
                                      );
                                }
                              },
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
