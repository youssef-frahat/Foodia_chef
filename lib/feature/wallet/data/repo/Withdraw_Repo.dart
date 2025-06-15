import 'package:dartz/dartz.dart';

import '../../../../core/models/failures.dart';
import '../model/Submit_Withdraw_Model/Submit_Withdraw_Model.dart';
import '../model/get_wallet_model/Withdraw_Response_Model.dart';

abstract class WithdrawRepo {
  Future<Either<Failure, WithdrawResponseModel>> getWithdraws();
  Future<Either<Failure, SubmitWithdrawModel>> submitWithdraw({
    required int amount,
  });
}
