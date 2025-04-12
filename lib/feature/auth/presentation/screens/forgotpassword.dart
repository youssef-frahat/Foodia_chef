import 'package:flutter/material.dart';
import 'package:foodia_chef/feature/auth/presentation/screens/login_page.dart';
import 'package:foodia_chef/feature/auth/presentation/widget/customs/styling.dart';

class ForgotpasswordPage extends StatelessWidget {
  const ForgotpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context, "استعاده كلمه المرور"),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "نسيت كلمه المرور؟",
                  style: mainText.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't worry! It occurs. Please enter the email address linked with your account.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: "Enter your email",
                  controller: TextEditingController(),
                  iconData: Icons.mail,
                ),
                const SizedBox(height: 20),

                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Remember Password?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
