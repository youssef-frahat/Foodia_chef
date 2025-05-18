import 'package:equatable/equatable.dart';

class UpdateStatusOrderRequestModel extends Equatable {
  final String method;
  final String status;

  const UpdateStatusOrderRequestModel({
    this.method = 'PUT',
    required this.status,
  });

  Map<String, String> toJson() {
    return {
      '_method': method,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [method, status];
}
