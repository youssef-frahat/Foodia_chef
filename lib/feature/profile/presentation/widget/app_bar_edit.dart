import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/widgets/buttons/back_button.dart';

class AppBarEditProfile extends StatelessWidget {
  const AppBarEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "تعديل بيانات الحساب ",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
          ),
        ),

        CustomBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
