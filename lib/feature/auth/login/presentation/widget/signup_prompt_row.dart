import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes.dart';

class SignupPromptRow extends StatelessWidget {
  final VoidCallback? onSignupTap;

  const SignupPromptRow({super.key, this.onSignupTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ---------------- OR Divider ----------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              const Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              const Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // ----------- Signup Text --------------
        GestureDetector(
          onTap: onSignupTap,
          child: Text.rich(
            TextSpan(
              text: "ليس لديك حساب؟ ",
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 16.sp,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 1,
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.goNamed(Routes.registerScreen);
                    },
                  text: "إنشاء حساب",
                  style: TextStyle(
                    color: Color(0xFFFFA500),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Changa',
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
