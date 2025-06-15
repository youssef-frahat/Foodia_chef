import 'package:equatable/equatable.dart';

import '../../../data/model/get_chef_model/get_chef_model.dart';

abstract class ChefProfileState extends Equatable {
  const ChefProfileState();

  @override
  List<Object?> get props => [];
}

class ChefProfileInitial extends ChefProfileState {}

class ChefProfileLoading extends ChefProfileState {}

class ChefProfileLoaded extends ChefProfileState {
  final GetChefProfileModel profile;

  const ChefProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ChefProfileError extends ChefProfileState {
  final String message;

  const ChefProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
