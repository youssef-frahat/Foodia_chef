import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/app_config/prefs_keys.dart';
import '../../../../../core/helpers/secure_local_storage.dart';
import '../../../data/model/edit_user_profile_model/edit_user_profile_model.dart';
import '../../../data/model/get_user_profile_model/get_user_profile_model.dart';
import '../../../data/repo/get_user_profile_repo_impl.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfileRepoImpl getUserProfileRepo;
  UserProfileCubit(this.getUserProfileRepo) : super(UserProfileInitial());

  Future<void> getUserProfile() async {
    emit(UserProfileLoading());

    try {
      final result = await getUserProfileRepo.getUserProfile();

      result.fold(
        (failure) {
          emit(UserProfileError(failure.message));
          log('Error fetching user profile: ${failure.message}');
        },
        (userProfile) {
          emit(UserProfileLoaded(userProfile));
          log('User profile loaded successfully');
        },
      );
    } catch (e) {
      emit(UserProfileError('Unexpected error: ${e.toString()}'));
      log('Unexpected error: $e');
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await getUserProfileRepo.logout();
    result.fold((failure) => emit(LogoutError(failure.message)), (success) {
      emit(LogoutSuccess());
      SecureLocalStorage.delete(PrefsKeys.user);
      SecureLocalStorage.delete(PrefsKeys.token);
    });
  }

  Future<void> updateUserProfile({
    required String name,
    required String email,
    required String phone,
    String? password,
    String? passwordConfirmation,
    String? currentPassword,
    required XFile? image,
  }) async {
    emit(EditeUserProfileLoading());

    try {
      final result = await getUserProfileRepo.updateUserProfile(
        name: name,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
        currentPassword: currentPassword,
        image: image,
      );

      if (isClosed) return;
      result.fold(
        (failure) {
          if (isClosed) return;
          emit(EditeUserProfileError(failure.message));
          log('Error updating user profile: ${failure.message}');
        },
        (userProfile) {
          if (isClosed) return;
          emit(EditeUserProfileSuccess(userProfile));
          log('User profile updated successfully');
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(EditeUserProfileError('Unexpected error: ${e.toString()}'));
      log('Unexpected error: $e');
    }
  }
}
