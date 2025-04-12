import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_config/app_icons.dart';
import '../svg_image/svg_image_widget.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.isSvg, this.width, this.height});
  final bool isSvg;
  final double? width, height;

  factory AppLogo.svg({double? width, double? height}) =>
      AppLogo(isSvg: true, width: width, height: height);

  factory AppLogo.png({double? width, double? height}) =>
      AppLogo(isSvg: false, width: width, height: height);

  @override
  Widget build(BuildContext context) {
    return isSvg
        ? SvgImageWidget(
            image: AppIcons.back,
            width: width ?? 111.w,
            height: height ?? 36.h,
          )
        : Image.asset(
            AppIcons.back,
            width: width ?? 111.w,
            height: height ?? 36.h,
          );
  }
}
