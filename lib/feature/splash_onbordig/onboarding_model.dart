import 'package:flutter/material.dart';

class OnboardingItem {
  final TextStyle textStyle;
  final TextStyle disStyle;
  final Text title;
  final Text description;
  final String image;

  OnboardingItem( {
    required this.textStyle,
    required this.title,
    required this.description,
    required this.image,
    required this.disStyle,
  });
}
