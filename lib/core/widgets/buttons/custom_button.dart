import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/font_styles.dart';

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
    this.height, required textColor,
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
                radius ?? Radius.circular(50),
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
                        child:
                            Text(text, style: style ?? FontStyles.textStyle16),
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
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final double borderRadius;
  final double width;
  const CustomElevationButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.fontSize = 16.0,
    this.padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
    this.elevation = 0.0,
    this.borderRadius = 50.0,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
