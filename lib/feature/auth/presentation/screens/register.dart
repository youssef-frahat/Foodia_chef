import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodia_chef/feature/auth/presentation/widget/customs/styling.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال اسم المستخدم';
    }
    if (value.length < 3) {
      return 'يجب أن يكون اسم المستخدم 3 أحرف على الأقل';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }
    if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
      return 'رقم الهاتف غير صالح';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال البريد الإلكتروني';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'البريد الإلكتروني غير صالح';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'كلمات المرور غير متطابقة';
    }
    return null;
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _emailController.text);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('فشل التسجيل: ${e.toString()}')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context, "إنشاء حساب جديد"),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 186,
                    height: 186,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'إنشاء حساب جديد',
                    style: mainText.copyWith(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 20),

                  // Username Field
                  SizedBox(
                    height: 51,
                    width: 320,
                    child: CustomTextField(
                      iconData: Icons.person,
                      hint: "اسم المستخدم",
                      controller: _usernameController,
                      validator: _validateUsername,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Phone Field
                  SizedBox(
                    height: 51,
                    width: 320,
                    child: CustomTextField(
                      iconData: Icons.phone,
                      hint: "رقم الهاتف",
                      controller: _phoneController,
                      validator: _validatePhone,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  SizedBox(
                    height: 51,
                    width: 320,
                    child: CustomTextField(
                      iconData: Icons.email,
                      hint: "البريد الإلكتروني",
                      controller: _emailController,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  SizedBox(
                    height: 51,
                    width: 320,
                    child: CustomTextField(
                      hint: "كلمة المرور",
                      controller: _passwordController,
                      isPassword: true,
                      iconData: Icons.lock,
                      validator: _validatePassword,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  SizedBox(
                    height: 51,
                    width: 320,
                    child: CustomTextField(
                      hint: "تأكيد كلمة المرور",
                      controller: _confirmPasswordController,
                      isPassword: true,
                      iconData: Icons.lock_outline,
                      validator: _validateConfirmPassword,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Register Button
                  elevatedButton(
                    height: 51,
                    width: 200,
                    text: "تسجيل",
                    onPressed: _register,
                  ),
                  const SizedBox(height: 20),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("لديك حساب بالفعل؟", style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 5),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "تسجيل الدخول",
                          style: mainText.copyWith(
                            color: Colors.orange,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
