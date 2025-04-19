import 'package:flutter/material.dart';
import 'package:foodia_chef/core/app_config/app_colors.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';

class RememberMeRow extends StatefulWidget {
  const RememberMeRow({super.key});

  @override
  State<RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<RememberMeRow> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: isRememberMe,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value ?? false;
                });
              },
              activeColor: AppColors.black,
              checkColor: Colors.white,
              side: const BorderSide(color: AppColors.black),
            ),
            Text(
              AppStrings.rememberMe,
              style: TextStyle(
                fontFamily: 'Changa',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFA500),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
      
          },
          child: Text(
            AppStrings.forgotPassword,
            style: TextStyle(
              fontFamily: 'Changa',
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
