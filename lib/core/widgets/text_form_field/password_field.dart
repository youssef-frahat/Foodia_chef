import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/app_icons.dart';
import 'custom_text_form_field.dart';

class PasswordField extends StatefulWidget {
  final String label, hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged; // ✅ أضفنا onChanged هنا

  const PasswordField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator,
    this.onChanged, // ✅ هنا برضو
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: widget.label,
      hint: widget.hint,
      controller: widget.controller,
      obscure: _obscure,
      validator: widget.validator,
      onChanged: widget.onChanged, // ✅ مررنا onChanged هنا
      maxLines: 1,
      suffix: IconButton(
        onPressed: _toggleVisibility,
        icon: !_obscure
            ? const Icon(
                Icons.visibility_outlined,
                color: AppColors.borderColor,
              )
            : SvgPicture.asset(
                AppIcons.eyeClosed,
                colorFilter: const ColorFilter.mode(
                  AppColors.borderColor,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }
}
