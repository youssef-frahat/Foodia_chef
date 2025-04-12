import 'package:flutter/material.dart';

class AppTextStyle {
  static  TextStyle? bebasText ({double? fontSize, FontWeight? fontWeight})=> TextStyle(
    fontFamily: 'Bebas Neue',
    fontSize: fontSize,
    fontWeight: fontWeight??FontWeight.w400,
  );

}