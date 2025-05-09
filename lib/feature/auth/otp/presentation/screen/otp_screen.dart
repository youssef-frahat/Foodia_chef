import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodia_chef/core/app_config/app_images.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/app_config/app_strings.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/helpers/messages.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/buttons/back_button.dart';
import '../logic/cubit/otp_user_cubit.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
    DateTime date = DateTime.now().add(const Duration(seconds: 9));
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
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => getIt<OtpUserCubit>(),
        child: BlocConsumer<OtpUserCubit, OtpUserState>(
          listener: (context, state) {
            if (state is ValidateOtpCodeLoading ||
                state is SendOtpCodeLoading) {
              AppMessages.showLoading(context);
            } else if (state is ValidateOtpCodeSuccess) {
              context.pop(); // Close loading
              AppMessages.showSuccess(context, AppStrings.verificationSuccess);
              context.pushNamed(Routes.bottomNavBar);
            } else if (state is ValidateOtpCodeError) {
              context.pop(); // Close loading
              AppMessages.showError(context, AppStrings.verificationFailed);
            } else if (state is SendOtpCodeSuccess) {
              context.pop(); // Close loading
              AppMessages.showSuccess(context, "تم إرسال الكود مرة أخرى بنجاح");
            } else if (state is SendOtpCodeError) {
              context.pop(); // Close loading
              AppMessages.showError(context, state.error);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 45,
                          width: 50,
                          child: CustomBackButton(
                            onPressed: () => context.pop(),
                          ),
                        )),
                    20.height,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  top: -300.sp,
                                  left: -72.sp,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 543.w,
                                      height: 543.h,
                                      decoration: BoxDecoration(
                                        color: Color(0x33F8A435),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -200.h,
                                  left: 220.r,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 392.w,
                                      height: 392.h,
                                      decoration: BoxDecoration(
                                        color: Color(0x33F69008),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(AppImages.otp, height: 250),
                                Positioned(
                                  top: 0.h,
                                  right: 0.r,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 27, vertical: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                          color: Colors.grey.shade400),
                                    ),
                                    child: Row(
                                      children:
                                          List.generate(otpLength, (index) {
                                        bool filled = index < otp.length;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
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
                                                  width: 1.5),
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
                                fontFamily: 'Changa',
                              ),
                            ),
                            10.height,
                            Text(
                              "لقد تم ارسال كود مكون من 4 أرقام على رقم الهاتف ${widget.phoneNumber} للتحقق منه",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Changa',
                                  fontSize: 14,
                                  color: Colors.grey),
                            ),
                            20.height,
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: PinCodeTextField(
                                appContext: context,
                                controller: _otpController,
                                length: otpLength,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                textStyle: const TextStyle(fontSize: 22),
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.circle,
                                  fieldHeight: 60,
                                  fieldWidth: 60,
                                  inactiveColor: Colors.orange.shade100,
                                  selectedColor: Colors.orange,
                                  activeColor: Colors.orange,
                                ),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: false,
                                keyboardType: TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: false,
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            10.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "لم يصلك كود تحقق؟ ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Changa',
                                  ),
                                ),
                                if (_duration != null &&
                                    _duration!.inSeconds > 0)
                                  Text(
                                    "إرسال مرة أخرى خلال ${_duration!.inSeconds} ثانية",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontFamily: 'Changa',
                                    ),
                                  )
                                else
                                  GestureDetector(
                                    onTap: () {
                                      context.read<OtpUserCubit>().sendOtpCode(
                                          phoneNumber: widget.phoneNumber);
                                      _startTimer();
                                    },
                                    child: const Text(
                                      "إرسال مرة أخرى",
                                      style: TextStyle(
                                        fontFamily: 'Changa',
                                        color: Colors.orange,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            20.height,
                          ],
                        ),
                      ),
                    ),
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
                          style: TextStyle(
                              fontFamily: 'Changa',
                              fontSize: 18,
                              color: Colors.white),
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
