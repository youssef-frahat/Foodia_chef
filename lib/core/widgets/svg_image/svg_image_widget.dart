import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_config/app_icons.dart';

class SvgImageWidget extends StatelessWidget {
  const SvgImageWidget(
      {super.key,
      required this.image,
      this.width,
      this.matchTextDirection,
      this.height,
      this.onTap,
      this.colorFilter});
  final String image;
  final double? height;
  final bool? matchTextDirection;
  final double? width;
  final ColorFilter? colorFilter;
  final Function()? onTap;
  factory SvgImageWidget.appLogo({double? width}) => SvgImageWidget(
        image: AppIcons.loginLogo,
        width: width,
      );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        matchTextDirection: matchTextDirection ?? false,
        image,
        width: width,
        height: height,
        colorFilter: colorFilter,
      ),
    );
  }
}
