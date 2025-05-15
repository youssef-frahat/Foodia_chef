import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodia_app/core/di/dependency_injection.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_config/app_strings.dart';
import '../../../../core/app_config/messages.dart';
import '../../../../core/extensions/spacing.dart';
import '../../../../core/routing/app_routes.dart';
import '../logic/cubit/user_profile_cubit.dart';
import 'profile_field.dart';

class ProfileBody extends StatelessWidget {
  ProfileBody({super.key});
  final SharedPreferences pref = getIt<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileError) {
          AppMessages.showError(context, state.error);
        } else if (state is LogoutError) {
          AppMessages.showError(context, state.error);
        } else if (state is LogoutSuccess) {
          AppMessages.showSuccess(context, AppStrings.logoutSuccess);
          context.go(AppRoutes.login);
        }
      },
      builder: (context, state) {
        if (state is UserProfileLoaded) {
          final userProfile = state.userProfile.data;

          if (userProfile == null) {
            return const Center(child: Text('لا توجد بيانات متاحة'));
          }

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      verticalSpace(25),
                      CircleAvatar(
                        radius: 60.r,
                        backgroundImage: NetworkImage(
                          userProfile.image?.isNotEmpty == true
                              ? (userProfile.image!.startsWith('http')
                                  ? userProfile.image!
                                  : AppStrings.baseUrl + userProfile.image!)
                              : "https://imgs.search.brave.com/CbGx149KMAUXiJtL17989JkvB2aupjBKAvcBtUva0Yc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzEyLzM1Lzc3LzY0/LzM2MF9GXzEyMzU3/NzY0NDFfakR5RHRZ/amNxdnhSV2RySnBv/aGp4b1YwRGRmdTVY/YWsuanBn",
                        ),
                      ),
                      verticalSpace(12),
                      Text(
                        userProfile.name ?? 'اسم غير متوفر',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(4),
                      Text(
                        userProfile.email ?? 'البريد الإلكتروني غير متوفر',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 10.h,
                    right: 60,
                    child: GestureDetector(
                      onTap: () async {
                        final result = await context.pushNamed(
                          AppRoutes.editProfileScreen,
                          extra: {
                            'name': userProfile.name ?? '',
                            'email': userProfile.email ?? '',
                            'phone': userProfile.phone ?? '',
                            'image': AppStrings.baseUrl + userProfile.image!,
                          },
                        );

                        if (result == true) {
                          context.read<UserProfileCubit>().getUserProfile();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 16.sp,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(30),
              ProfileField(
                title: 'الاسم:',
                value: userProfile.name ?? 'اسم غير متوفر',
              ),
              ProfileField(
                title: 'رقم الهاتف:',
                value: userProfile.phone ?? 'رقم الهاتف غير متوفر',
              ),
              ProfileField(
                title: 'البريد الالكتروني:',
                value: userProfile.email ?? 'البريد الإلكتروني غير متوفر',
              ),

              verticalSpace(60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: ElevatedButton(
                  onPressed: () {
                    pref.remove('isLoggedIn');
                    context.read<UserProfileCubit>().logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: BorderSide(color: Colors.red, width: 2.0.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8.w),
                      Text(
                        'تسجيل الخروج',
                        style: TextStyle(color: Colors.red, fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(20),
            ],
          );
        } else if (state is LogoutLoading ||
            state is UserProfileLoading ||
            state is UserProfileInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserProfileError) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
