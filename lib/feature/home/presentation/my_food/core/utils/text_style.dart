import 'package:flutter/material.dart';

TextStyle headlinestyle(
  BuildContext? context, {
  double? fontSize,
  Color? color,
  FontWeight? fontwigth,
}) {
  return TextStyle(
    fontFamily: 'Changa',
    fontSize: fontSize ?? 30,
    fontWeight: fontwigth ?? FontWeight.normal,
    color: color ?? Theme.of(context!).colorScheme.onSurface,
  );
}

TextStyle gettitlestyle(
  BuildContext? context, {
  double? fontSize,
  Color? color,
  FontWeight? fontwigth,
}) {
  return TextStyle(
    fontFamily: 'Changa',
    fontSize: fontSize ?? 24,
    fontWeight: fontwigth ?? FontWeight.bold,
    color: color ?? Theme.of(context!).colorScheme.onSurface,
  );
}

TextStyle getBodyTextStyle(
  BuildContext? context, {
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontFamily: 'Changa',
    fontSize: fontSize ?? 18,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color ?? Theme.of(context!).colorScheme.onSurface,
  );
}

TextStyle getSmallTextStyle(
  BuildContext? context, {
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontFamily: 'Changa',
    fontSize: fontSize ?? 16,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color,
  );
}

TextStyle getSmall17(
  BuildContext? context, {
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontFamily: 'Changa',
    fontSize: fontSize ?? 17,
    fontWeight: FontWeight.bold,
    color: color,
  );
}
