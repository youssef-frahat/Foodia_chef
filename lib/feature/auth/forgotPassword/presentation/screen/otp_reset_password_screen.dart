import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/helpers/messages.dart';
import '../../../../../core/routes/routes.dart';
import '../../../otp/presentation/logic/cubit/otp_user_cubit.dart';
import '../../../otp/presentation/screen/widget/custome_pinput.dart';


class OtpResetPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpResetPasswordScreen({super.key, required this.phoneNumber});

  @override
  State<OtpResetPasswordScreen> createState() => _OtpResetPasswordScreenState();
}

class _OtpResetPasswordScreenState extends State<OtpResetPasswordScreen> {
  Timer? _timer;
  Duration? _duration;
  final TextEditingController _otpController = TextEditingController();
  final int otpLength = 4;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    DateTime date = DateTime.now().add(const Duration(seconds: 15));
    _duration = date.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      setState(() {
        _duration = date.difference(DateTime.now());
        if (_duration!.isNegative) {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String otp = _otpController.text;

    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<OtpUserCubit>(),
        child: BlocConsumer<OtpUserCubit, OtpUserState>(
          listener: (context, state) {
            if (!context.mounted) return;

            if ((state is ValidateOtpCodeLoading ||
                    state is SendOtpCodeLoading) &&
                ModalRoute.of(context)?.isCurrent == true) {
              AppMessages.showLoading(context);
            } else if (state is ValidateOtpCodeSuccess) {
              context.pop();
              AppMessages.showSuccess(context, AppStrings.otpVerified);

              context.goNamed(
                Routes.changePasswordScreen,
                extra: widget.phoneNumber,
              );
            } else if (state is ValidateOtpCodeError) {
              context.pop();
              AppMessages.showError(context, AppStrings.codeIsInvalid);
            } else if (state is SendOtpCodeSuccess) {
              context.pop();
              AppMessages.showSuccess(context, "تم إرسال الكود مرة أخرى بنجاح");
            } else if (state is SendOtpCodeError) {
              context.pop();
              AppMessages.showError(context, state.error);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    10.height,
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset("assets/images/otp.jpg", height: 250),
                        Positioned(
                          top: -20,
                          right: -40,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: Row(
                              children: List.generate(otpLength, (index) {
                                bool filled = index < otp.length;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: filled
                                          ? Colors.orange
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 220.w,
                      child: const Divider(
                        color: Color(0xFF292A2E),
                        thickness: 1.2,
                      ),
                    ),
                    16.height,
                    const Text(
                      "ادخل كود التحقق",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "لقد تم ارسال كود مكون من 4 أرقام على رقم الهاتف ${widget.phoneNumber} للتحقق منه",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    20.height,
                    CustomPinput(
                      otpController: _otpController,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    10.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("لم يصلك كود تحقق؟ "),
                        if (_duration != null && _duration!.inSeconds > 0)
                          Text(
                            "إرسال مرة أخرى خلال ${_duration!.inSeconds} ثانية",
                            style: const TextStyle(color: Colors.grey),
                          )
                        else
                          GestureDetector(
                            onTap: () {
                              context.read<OtpUserCubit>().sendOtpCode(
                                phoneNumber: widget.phoneNumber,
                              );
                              _startTimer();
                            },
                            child: const Text(
                              "إرسال مرة أخرى",
                              style: TextStyle(
                                color: Colors.orange,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: otp.length == otpLength
                            ? () {
                                context.read<OtpUserCubit>().validateOtpCode(
                                      phoneNumber: widget.phoneNumber,
                                      otpCode: otp,
                                    );
                              }
                            : null,
                        child: const Text(
                          "تأكيد",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  20.height,
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
