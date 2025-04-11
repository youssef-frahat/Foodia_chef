// import 'package:bokiaaa/customs/navigate.dart';
// import 'package:bokiaaa/customs/subtext.dart';
// import 'package:bokiaaa/pages/login/login.dart';
// import 'package:flutter/material.dart';

// import '../../customs/custom_button.dart';
// import '../../customs/maintext.dart';

// class PasswordChangedPage extends StatelessWidget {
//   const PasswordChangedPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Icon(
//                   Icons.check_circle,
//                   color: Colors.green,
//                   size: 100,
//                 ),
//                 const SizedBox(height: 20),
//                 Maintext(text: "Password Changed!"),
//                 const SizedBox(height: 10),
//                 Subtext(
//                   text: const Text(
//                     "Your password has been changed successfully.",
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                  CustomButton(
//                   text: "Back to Login",
//                   function:Navigate( context,LoginPage(), ), // Replace with your login page widget
//                   width: double.infinity,
//                   height: 50,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
