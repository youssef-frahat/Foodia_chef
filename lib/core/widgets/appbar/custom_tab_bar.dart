import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_config/app_colors.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(int? index)? onTap;
  final String tab1Title, tab2Title;

  const CustomTabBar({
    super.key,
    required this.onTap,
    required this.tab1Title,
    required this.tab2Title,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Colors.transparent,
      tabs: [
        Tab(text: tab1Title),
        Tab(text: tab2Title),
      ],
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColors.primaryColor,
      indicatorWeight: 5,
      labelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w400,
          ),
      labelColor: Theme.of(context).textTheme.labelLarge?.color,
      unselectedLabelColor: Theme.of(context).textTheme.labelLarge?.color,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
