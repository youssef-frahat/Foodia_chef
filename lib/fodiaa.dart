import 'package:flutter/material.dart';
import 'package:foodia_chef/splash_onbordig/onbording.dart';

class Foodia extends StatelessWidget {
  const Foodia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}