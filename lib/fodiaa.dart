import 'package:flutter/material.dart';
import 'package:foodia_chef/auth/page/login_page.dart';
import 'package:foodia_chef/home.dart';
import 'package:foodia_chef/splash_onbordig/onbording.dart';

class Foodia extends StatelessWidget {
  const Foodia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodia Chef',

      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
