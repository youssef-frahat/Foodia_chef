import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.title, required this.onTap});
  final Function()? onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
        /*       clickableTextStyle: ,
        text: '',
        clickableText: ,*/
      ),
    );
  }
}
