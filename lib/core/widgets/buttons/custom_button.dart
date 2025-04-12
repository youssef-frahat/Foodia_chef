import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final bool isBackgroundGradient;
  final Gradient? gradient;
  final bool hasBorder, enabled;
  final Color? borderColor;
  final TextStyle? style;
  final void Function()? onTap;
  final double? fontSize;
  final Widget? icon, prefix;
  final Widget? widget;
  final EdgeInsets? padding;
  final Radius? radius;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.style,
    this.enabled = true,
    this.backgroundColor,
    this.isBackgroundGradient = false,
    this.hasBorder = false,
    this.borderColor,
    this.fontSize,
    this.icon,
    this.prefix,
    this.widget,
    this.padding,
    this.radius,
    this.gradient,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: IgnorePointer(
        ignoring: !enabled,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: padding ?? EdgeInsets.symmetric(vertical: 14.h),
            width: width ?? double.infinity,
            height: height ?? 48.h,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.primaryColor,
              border: hasBorder
                  ? Border.all(
                      width: 1.w,
                      color: borderColor ?? AppColors.primaryColor,
                    )
                  : null,
              borderRadius: BorderRadius.all(
                radius ?? Radius.circular(50), // زوايا دائرية كاملة
              ),
              gradient: isBackgroundGradient ? gradient : null,
            ),
            child: widget ??
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefix != null) ...[
                      prefix!,
                      SizedBox(width: 8.w),
                    ],
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          text,
                          style: style ??
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize ?? 18.sp,
                                  ),
                        ),
                      ),
                    ),
                    if (icon != null) ...[
                      SizedBox(width: 8.w),
                      icon!,
                    ],
                  ],
                ),
          ),
        ),
      ),
    );
  }
}


class CustomElevationButton extends StatelessWidget {
  const CustomElevationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text(""),
        ));
  }
}
