import 'package:equatable/equatable.dart';

class SubmitWithdrawModel extends Equatable {
  final bool? status;
  final String? message;
  final dynamic data; // أو تقدر تخليه Null أو Object حسب استخدامك

  const SubmitWithdrawModel({
    this.status,
    this.message,
    this.data,
  });

  factory SubmitWithdrawModel.fromJson(Map<String, dynamic> json) {
    return SubmitWithdrawModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'], // null أو ممكن لاحقًا يكون object
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };

  @override
  List<Object?> get props => [status, message, data];
}
