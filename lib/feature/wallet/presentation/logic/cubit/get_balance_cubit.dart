import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/failures.dart';
import '../../../data/model/add_to_balance_model/add_to_balance_model.dart';
import '../../../data/model/get_wallet_model/get_wallet_model.dart';
import '../../../data/repo/walet_repo_impl.dart';

part 'get_balance_state.dart';

class GetBalanceCubit extends Cubit<GetBalanceState> {
  final WaletRepoImpl walletRepo;
  GetBalanceCubit(this.walletRepo) : super(GetBalanceInitial());

  Future<void> getBalance() async {
    emit(GetBalanceLoading());
    final result = await walletRepo.getBalance();
    result.fold(
      (l) => emit(GetBalanceFailure(l)),
      (r) => emit(GetBalanceSuccess(r)),
    );
  }

  addBalance({required int amount}) async {
    emit(AddingBalanceLoading());
    final result = await walletRepo.addBalance(amount: amount);
    result.fold((l) => emit(AddBalanceFailure(l)), (r) {
      emit(AddBalanceSuccess(r));
      getBalance();
    });
  }
}
