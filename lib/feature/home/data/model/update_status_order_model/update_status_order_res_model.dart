import 'package:equatable/equatable.dart';

class UpdateStatusOrderResponseModel extends Equatable {
  final String message;
  final String wallet;

  const UpdateStatusOrderResponseModel({
    required this.message,
    required this.wallet,
  });

  factory UpdateStatusOrderResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateStatusOrderResponseModel(
      message: json['message'] ?? '',
      wallet: json['wallet']?.toString() ?? '0.00',
    );
  }

  @override
  List<Object?> get props => [message, wallet];
}
