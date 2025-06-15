import 'package:equatable/equatable.dart';
import 'package:foodia_chef/feature/auth/login/data/model/auth_response_model/register/register_data.dart';

class RegisterResponseModel extends Equatable {
  final bool? status;
  final String? message;
  final RegisterData? data;

  const RegisterResponseModel({this.status, this.message, this.data});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : RegisterData.fromJson(json['data'] as Map<String, dynamic>),
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
