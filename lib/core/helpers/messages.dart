import 'package:flutter/material.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: const Border(
              top: BorderSide(
                color: Colors.red,
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            error,
            style: const TextStyle(
              color: AppColors.primaryColor,
            ),
          ),
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
            border: Border(
              top: BorderSide(
                color: Colors.green,
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.orange,
            ),
          ),
        ),
        action: action,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
