import 'package:bloc/bloc.dart';
import 'package:foodia_chef/core/models/failures.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_chef/get_chef_state.dart';

import '../../../data/model/get_chef_model/get_chef_model.dart';
import '../../../data/repo/get_chef/get_chef_repo.dart';

class ChefProfileCubit extends Cubit<ChefProfileState> {
  final GetChefProfileRepo repo;

  ChefProfileCubit(this.repo) : super(ChefProfileInitial());

  Future<void> getChefProfile() async {
    emit(ChefProfileLoading());

    final result = await repo.getChefProfile();

    result.fold(
      (Failure failure) => emit(ChefProfileError(failure.message)),
      (GetChefProfileModel model) => emit(ChefProfileLoaded(model)),
    );
  }
}
