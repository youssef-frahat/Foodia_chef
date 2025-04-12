import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../app_config/app_icons.dart';
import '../svg_image/svg_image_widget.dart';


class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: onPressed ?? () => context.pop(),
        child: SvgImageWidget(
          image: AppIcons.back,
          width: 40.w,
          height: 40.h,
        ),
      ),
    );
  }
}
