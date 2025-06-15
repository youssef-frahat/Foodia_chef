import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_config/app_colors.dart';
import '../../app_config/font_styles.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String? label;
  final TextEditingController? controller;
  final bool obscure, readOnly;
  final TextInputType? keyboardType;
  final Widget? prefix, suffix;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final int? minLines, maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? textStyle, labelStyle;
  final Function(String)? onChanged;
  final double? borderRadius;
  const CustomTextField({
    super.key,
    this.label,
    required this.hint,
    this.controller,
    this.obscure = false,
    this.readOnly = false,
    this.keyboardType,
    this.prefix,
    this.suffix,
    this.validator,
    this.onTap,
    this.minLines,
    this.maxLines,
    this.inputFormatters,
    this.textStyle,
    this.onChanged,
    this.labelStyle,
    this.borderRadius,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String _validationMessage = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.label != null) ...[
              if (widget.label!.isNotEmpty) ...[
                Text.rich(
                  TextSpan(
                    text: widget.label,
                    children: [
                      if (_validationMessage.isNotEmpty)
                        const TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: AppColors.errorColor,
                          ),
                        )
                    ],
                  ),
                  style: widget.labelStyle ??
                      FontStyles.textStyle16
                          .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ],
            if (widget.label != null) ...[
              if (_validationMessage.isNotEmpty)
                Expanded(
                  child: Text(
                    _validationMessage,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyles.textStyle12.copyWith(
                      color: AppColors.errorColor,
                    ),
                  ),
                ),
            ],
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        TextFormField(
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          controller: widget.controller,
          obscureText: widget.obscure,
          keyboardType: widget.keyboardType,
          minLines: widget.minLines,
          maxLines: widget.maxLines ?? 1,
          inputFormatters: widget.inputFormatters,
          validator: (text) {
            String? value = widget.validator?.call(text);
            setState(() {
              _validationMessage = value ?? '';
            });
            return value != null ? '' : null;
          },
          style: widget.textStyle,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: FontStyles.textStyle14,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                color: AppColors.errorColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(
                color: Colors.orange,
                width: 1,
              ),
            ),
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
          ),
        ),
      ],
    );
  }
}
