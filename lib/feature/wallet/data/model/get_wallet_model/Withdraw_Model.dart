import 'package:equatable/equatable.dart';

class WithdrawModel extends Equatable {
  final int? id;
  final int? chefId;
  final String? amount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const WithdrawModel({
    this.id,
    this.chefId,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) {
    return WithdrawModel(
      id: json['id'] as int?,
      chefId: json['chef_id'] as int?,
      amount: json['amount'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'chef_id': chefId,
        'amount': amount,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, chefId, amount, status, createdAt, updatedAt];
}
