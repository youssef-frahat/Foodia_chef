import 'package:flutter/material.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';

import '../app_config/font_styles.dart';

class ScreenTitleWidget extends StatelessWidget {
  const ScreenTitleWidget({
    super.key,
    required this.title,
    this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
    this.hasSubtitle,
    this.centerTitle,
  });
  final String title;
  final String? subTitle;
  final TextStyle? titleStyle, subTitleStyle;
  final bool? hasSubtitle;
  final bool? centerTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 24.height,
        centerTitle == true
            ? Center(
                child: Text(
                  title,
                  style: titleStyle ?? FontStyles.textStyle24,
                ),
              )
            : Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: titleStyle ?? FontStyles.textStyle24,
                    ),
                  ),
                ],
              ),
        if (hasSubtitle == true && subTitle != null)
          Column(
            children: [
              16.height,
              Text(
                subTitle!,
                textAlign: TextAlign.start,
                style: subTitleStyle ?? FontStyles.textStyle14,
              ),
            ],
          ),
      ],
    );
  }
}
