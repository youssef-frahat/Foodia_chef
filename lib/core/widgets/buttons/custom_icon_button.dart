import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_config/app_colors.dart';
import '../svg_image/svg_image_widget.dart';


class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {super.key,
      required this.icon,
      this.iconSize,
      this.bgSize,
      this.bgColor,
      this.bgRadius,
      this.onTap,
      this.padding});
  final String icon;
  final double? iconSize, bgSize, bgRadius, padding;
  final Color? bgColor;
  final Function()? onTap;
  factory CustomIconButton.lightBlueBg(
          {required Function()? onTap, required String icon}) =>
      CustomIconButton(
        icon: icon,
        bgColor: AppColors.barColor,
        onTap: onTap,
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bgRadius ?? 6.r),
        color:bgColor?? AppColors.bgCard,
      ),
      child: SvgImageWidget(
        image: icon,
        onTap: onTap,
        width: iconSize?.h,
        height: iconSize?.w,
      ),
    );
  }
}
