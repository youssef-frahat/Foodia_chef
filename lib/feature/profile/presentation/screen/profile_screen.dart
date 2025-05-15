import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_app/core/app_config/app_strings.dart';

import '../../../../core/app_config/font_styles.dart';
import '../../../../core/di/dependency_injection.dart';
import '../logic/cubit/user_profile_cubit.dart';
import '../widget/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final UserProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<UserProfileCubit>();
    _cubit.getUserProfile();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<UserProfileCubit>();
        cubit.getUserProfile();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.profile, style: FontStyles.body25W600),
          centerTitle: true,
        ),
        body: ProfileBody(),
      ),
    );
  }
}
