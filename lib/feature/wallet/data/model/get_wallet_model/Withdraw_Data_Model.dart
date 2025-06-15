import 'package:equatable/equatable.dart';
import 'withdraw_model.dart';

class WithdrawDataModel extends Equatable {
  final List<WithdrawModel>? withdraws;
  final String? wallet;

  const WithdrawDataModel({this.withdraws, this.wallet});

  factory WithdrawDataModel.fromJson(Map<String, dynamic> json) {
    return WithdrawDataModel(
      withdraws: (json['withdraws'] as List<dynamic>?)
          ?.map((e) => WithdrawModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      wallet: json['wallet'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'withdraws': withdraws?.map((e) => e.toJson()).toList(),
        'wallet': wallet,
      };

  @override
  List<Object?> get props => [withdraws, wallet];
}
