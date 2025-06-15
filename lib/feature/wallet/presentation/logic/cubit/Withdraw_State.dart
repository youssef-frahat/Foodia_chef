
import 'package:equatable/equatable.dart';

import '../../../../../core/models/failures.dart';
import '../../../data/model/Submit_Withdraw_Model/Submit_Withdraw_Model.dart';
import '../../../data/model/get_wallet_model/Withdraw_Response_Model.dart';

sealed class WithdrawState extends Equatable {
  const WithdrawState();

  @override
  List<Object> get props => [];
}

final class WithdrawInitial extends WithdrawState {}

final class WithdrawsLoading extends WithdrawState {}

final class WithdrawsSuccess extends WithdrawState {
  final WithdrawResponseModel model;
  const WithdrawsSuccess(this.model);

  @override
  List<Object> get props => [model];
}

final class WithdrawsFailure extends WithdrawState {
  final Failure failure;
  const WithdrawsFailure(this.failure);

  @override
  List<Object> get props => [failure];
}

final class SubmittingWithdrawLoading extends WithdrawState {}

final class SubmitWithdrawSuccess extends WithdrawState {
  final SubmitWithdrawModel model;
  const SubmitWithdrawSuccess(this.model);

  @override
  List<Object> get props => [model];
}

final class SubmitWithdrawFailure extends WithdrawState {
  final Failure failure;
  const SubmitWithdrawFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
