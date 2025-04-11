// import 'package:bokiaaa/customs/navigate.dart';
// import 'package:bokiaaa/pages/login/paswwordchanged.dart';
// import 'package:flutter/material.dart';

// import '../../customs/custom_button.dart';
// import '../../customs/maintext.dart';
// import '../../customs/otpbox.dart';

// class OTPPage extends StatelessWidget {
//   const OTPPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_rounded, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Maintext(text: "OTP Verification"),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "Enter the verification code we just sent on your email address.",
//                   style: TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     OTPInputBox(),
//                     OTPInputBox(),
//                     OTPInputBox(),
//                     OTPInputBox(),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                  CustomButton(
//                   text: "Verify",
//                   function:Navigate(context, const PasswordChangedPage(), ),
//                   width: double.infinity,
//                   height: 50,
//                 ),
//                 const Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text("Didn't receive code?"),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text("Resend"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
