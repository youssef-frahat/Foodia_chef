import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleOutlinedIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;
  final double? size;
  const CustomCircleOutlinedIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 52.w,
      height: size ?? 52.w,
      child: IconButton(
        onPressed: onPressed ?? () {},
        style: IconButton.styleFrom(
          foregroundColor: color,
          shape: CircleBorder(
            side: BorderSide(
              color: color ?? Colors.transparent,
            ),
          ),
        ),
        icon: icon,
      ),
    );
  }
}
