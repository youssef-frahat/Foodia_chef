import 'package:flutter/material.dart';

import '../../../../core/app_config/app_strings.dart';
import '../../../../core/app_config/font_styles.dart';
import '../widget/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.profile, style: FontStyles.body25W600),
        centerTitle: true,
      ),
      body: ProfileBody(),
    );
  }
}
