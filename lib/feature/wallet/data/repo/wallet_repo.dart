import 'package:dartz/dartz.dart';

import '../../../../core/models/failures.dart';
import '../model/add_to_balance_model/add_to_balance_model.dart';
import '../model/get_wallet_model/get_wallet_model.dart';

abstract class WalletRepo {
  Future<Either<Failure, GetWalletModel>> getBalance();
  Future<Either<Failure, AddToBalanceModel>> addBalance({required int amount});
}
