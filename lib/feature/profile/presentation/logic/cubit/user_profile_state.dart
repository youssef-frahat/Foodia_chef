part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserProfileLoading extends UserProfileState {}

final class UserProfileLoaded extends UserProfileState {
  final GetUserProfileModel userProfile;

  const UserProfileLoaded(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

final class UserProfileError extends UserProfileState {
  final String error;

  const UserProfileError(this.error);

  @override
  List<Object> get props => [error];
}

//! logout
final class LogoutLoading extends UserProfileState {}

final class LogoutSuccess extends UserProfileState {}

final class LogoutError extends UserProfileState {
  final String error;
  const LogoutError(this.error);

  @override
  List<Object> get props => [error];
}

final class EditeUserProfileLoading extends UserProfileState {}

final class EditeUserProfileSuccess extends UserProfileState {
  final EditUserProfileModel userProfile;

  const EditeUserProfileSuccess(this.userProfile);

  @override
  List<Object> get props => [userProfile];
}

final class EditeUserProfileError extends UserProfileState {
  final String error;

  const EditeUserProfileError(this.error);

  @override
  List<Object> get props => [error];
}
