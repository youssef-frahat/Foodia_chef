// import 'package:flutter/material.dart';
// import 'forgotpassword.dart';
// import 'register.dart';
// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final GlobalKey<FormState> formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Row(
//           children: [
//             IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.arrow_back_rounded),
//             ),
//             const SizedBox(width: 10),
//             const Image(
//               image: AssetImage("assets/image/Group 2918.png"),
//               fit: BoxFit.fitWidth,
//             ),
//           ],
//         ),
//         leadingWidth: 300,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Form(
//         key: formkey,
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 30),
//                   Maintext(text: "Welcome back! Glad to see you, Again!"),
//                   const SizedBox(height: 20),
//                   CustomTextField(
//                     iconData: Icons.mail,
//                     hint: "Enter your E_mail",
//                     controller: emailController,
//                   ),
//                   const SizedBox(height: 20),
//                   CustomTextField(
//                     hint: "Enter your Password",
//                     controller: passwordController,
//                     isPassword: true,
//                     iconData: Icons.lock,
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) {
//                             return const ForgotpasswordPage();
//                           }),
//                         );
//                       },
//                       child: const Text("Forgot your password?"),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   BlocConsumer<AuthCupit, AuthStates>(
//                     listener: (context, state) {
//                       if (state is LoginErrorstate) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Error")),
//                         );
//                       } else {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(builder: (context) {
//                           return const HomeScreen();
//                         }));
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is LoginLoadingstate) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else {
//                         return ElevatedButton(
//                           onPressed: () {
//                             if (formkey.currentState!.validate()) {
//                               BlocProvider.of<AuthCupit>(context).loginState(
//                                   email: emailController.text,
//                                   password: passwordController.text);
//                             }
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: WidgetStateProperty.all(
//                               const Color.fromARGB(255, 160, 83, 1),
//                             ),
//                           ),
//                           child: const Text(
//                             "Login",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   const Center(child: Text("or log in with")),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.facebook),
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.mail),
//                       ),
//                       IconButton(
//                         onPressed: () {},
//                         icon: const Icon(Icons.apple),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account?"),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               return const RegisterPage();
//                             }),
//                           );
//                         },
//                         child: const Text("You can register"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
