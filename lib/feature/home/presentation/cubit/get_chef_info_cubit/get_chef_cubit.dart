import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/feature/home/presentation/cubit/get_chef_info_cubit/get_chef_state.dart';
import 'package:foodia_chef/feature/home/data/repo/get_orders/get_orders_repo.dart';

class ChefCubit extends Cubit<ChefState> {
  final GetOrdersRepo chefRepository;

  ChefCubit(this.chefRepository) : super(ChefInitial());

  Future<void> getChefData() async {
    emit(ChefLoading());

    final chefResult = await chefRepository.getChefInfo();
    final statsResult = await chefRepository.getChefStatistics();

    chefResult.fold(
      (failure) => emit(ChefError(failure.message)),
      (chef) {
        statsResult.fold(
          (failure) => emit(ChefError(failure.message)),
          (statistics) => emit(ChefLoaded(chef: chef, statistics: statistics)),
        );
      },
    );
  }
}
