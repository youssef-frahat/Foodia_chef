import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:foodia_chef/core/widgets/buttons/custom_button.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_config/app_colors.dart';
import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/helpers/messages.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/text_form_field/my_text_form_faield.dart';
import '../logic/forgetPassword/cubit/forget_password_cubit.dart';

class ForgotPassowrdChenge extends StatefulWidget {
  final String phoneNumber;
  const ForgotPassowrdChenge({super.key, required this.phoneNumber});

  @override
  State<ForgotPassowrdChenge> createState() => _ForgotPassowrdChengeState();
}

class _ForgotPassowrdChengeState extends State<ForgotPassowrdChenge> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "اعادة تعيين كلمة المرور",
          style: TextStyle(fontFamily: 'Changa', fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => getIt<ForgetPasswordCubit>(),
        child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordLoading) {
              AppMessages.showLoading(context);
            } else if (state is ResetPasswordSuccess) {
              context.pop();
              AppMessages.showSuccess(context, "تم تغيير كلمة المرور بنجاح");
              context.goNamed(Routes.login);
            } else if (state is ResetPasswordError) {
              context.pop();
              AppMessages.showError(context, state.message);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    150.height,
                    MyTextFormField(
                      hintText: 'ادخل كلمة السر',
                      isPassword: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppStrings.pleaseEnterYourPassword;
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف أو أكثر';
                        }
                        return null;
                      },
                    ),
                    20.height,
                    MyTextFormField(
                      hintText: 'تاكد كلمة السر',
                      isPassword: true,
                      controller: _passwordConfirmController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppStrings.pleaseEnterYourPassword;
                        }
                        if (value.length < 6) {
                          return 'كلمة المرور يجب أن تكون 6 أحرف أو أكثر';
                        }
                        return null;
                      },
                    ),
                    50.height,
                    CustomButton(
                      text: 'اعادة تعين كلمة السر',
                      backgroundColor: AppColors.primaryColor,
                      height: 48.h,
                      radius: Radius.circular(50.r),
                      textColor: Colors.white,
                      onTap:
                          state is ResetPasswordLoading
                              ? null
                              : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  if (_passwordController.text.trim() !=
                                      _passwordConfirmController.text.trim()) {
                                    AppMessages.showError(
                                      context,
                                      "كلمة المرور غير متطابقة",
                                    );
                                    return;
                                  }
                                  context
                                      .read<ForgetPasswordCubit>()
                                      .resetPassword(
                                        phone: widget.phoneNumber,
                                        password:
                                            _passwordController.text.trim(),
                                        conPassword:
                                            _passwordConfirmController.text
                                                .trim(),
                                      );
                                }
                              },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
