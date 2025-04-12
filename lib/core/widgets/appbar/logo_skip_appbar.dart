import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../buttons/back_button.dart';
import '../logo/app_logo.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({
    super.key,
    this.customTitle,
    this.leading,
    this.title,
    this.centerTitle,
    this.bottomWidget,
    this.isShown,
  });

  final Widget? customTitle;
  final Widget? leading;
  final PreferredSizeWidget? bottomWidget;
  final String? title;
  final bool? centerTitle, isShown;
  factory CustomAppBar.logoSkipAppBar({Function()? onTap}) => CustomAppBar(
        
        customTitle: AppLogo.svg(),
      );
  factory CustomAppBar.logoAppBar() => CustomAppBar(
        leading: null,
        customTitle: AppLogo.svg(),
      );
  factory CustomAppBar.backAppBar(
          {String? title,
          PreferredSizeWidget? bottomWidget,
          bool? centerTitle,
          VoidCallback? onBackPressed}) =>

      CustomAppBar(
        centerTitle: centerTitle,
        leading: CustomBackButton(
          onPressed: onBackPressed,
        ),
        title: title,
        bottomWidget: bottomWidget,
      );
  factory CustomAppBar.homeAppBar(
          {VoidCallback? onLogoTap,
          bool? isShown,
          PreferredSizeWidget? bottomWidget}) =>
      CustomAppBar(
        centerTitle: true,
        isShown: isShown,
        bottomWidget: bottomWidget,
        customTitle: GestureDetector(
          onTap: onLogoTap,
          child: AppLogo.svg(),
        ),
      );
  @override
  Widget build(BuildContext context) {
    double height = bottomWidget != null
        ? kToolbarHeight + kTextTabBarHeight
        : kToolbarHeight;
    return AppBar(
      centerTitle: centerTitle ?? true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leadingWidth: 60.w,
      leading: leading == null ? null : Center(child: leading),
      toolbarHeight: height,
      bottom: bottomWidget,
      title: customTitle ??
          (title != null
              ? Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 18.sp),
                )
              : null),
    );
  }

  @override
  // TODO: implement child
  Widget get child => AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        offset: Offset(0, isShown ?? false ? 0 : -kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 60.w,
        
          title: AppLogo.svg(),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
