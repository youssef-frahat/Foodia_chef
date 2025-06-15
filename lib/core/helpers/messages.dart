import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_chef/core/extensions/space_extension.dart';

import '../app_config/app_colors.dart';

class AppMessages {
  static Future<dynamic> showLoading(BuildContext context) =>
      showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );

  static void showError(BuildContext context, String error,
      [SnackBarAction? action]) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.secondaryButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          side: const BorderSide(
            color: AppColors.secondaryColor,
          ),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.error_sharp,
              color: AppColors.errorColor,
            ),
            8.width,
            Flexible(
              child: Text(
                error,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Bebas Neue',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
        action: action,
      ),
    );
  }

  static void showSuccess(BuildContext context, String message,
      [SnackBarAction? action]) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.secondaryButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          side: const BorderSide(
            color: AppColors.secondaryColor,
          ),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            8.width,
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Bebas Neue',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
        action: action,
      ),
    );
  }
}
