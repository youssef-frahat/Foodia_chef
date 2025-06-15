import 'package:equatable/equatable.dart';
import 'withdraw_data_model.dart';

class WithdrawResponseModel extends Equatable {
  final bool? status;
  final String? message;
  final WithdrawDataModel? data;

  const WithdrawResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory WithdrawResponseModel.fromJson(Map<String, dynamic> json) {
    return WithdrawResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : WithdrawDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [status, message, data];
}
