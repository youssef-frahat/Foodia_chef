import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/withdraw_repo.dart'; // استيراد الـ interface
import 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  final WithdrawRepo withdrawRepo; // استخدام البروتوكول وليس الـ implementation

  WithdrawCubit(this.withdrawRepo) : super(WithdrawInitial());

  Future<void> getWithdraws() async {
    emit(WithdrawsLoading());
    final result = await withdrawRepo.getWithdraws();
    result.fold(
      (failure) => emit(WithdrawsFailure(failure)),
      (data) => emit(WithdrawsSuccess(data)),
    );
  }

  Future<void> submitWithdraw({required int amount}) async {
    emit(SubmittingWithdrawLoading());
    final result = await withdrawRepo.submitWithdraw(amount: amount);
    result.fold(
      (failure) => emit(SubmitWithdrawFailure(failure)),
      (response) {
        emit(SubmitWithdrawSuccess(response));
        getWithdraws(); // Refresh after success
      },
    );
  }
}
