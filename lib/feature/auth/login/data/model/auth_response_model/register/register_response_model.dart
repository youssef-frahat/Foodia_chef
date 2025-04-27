import 'package:equatable/equatable.dart';
import 'register_data.dart';

class RegisterResponseModel extends Equatable {
	final bool? status;
	final String? message;
	final RegisterData? data;

	const RegisterResponseModel({this.status, this.message, this.data});

	factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
		return RegisterResponseModel(
			status: json['status'] as bool?,
			message: json['message'] as String?,
			data: json['data'] != null
					? RegisterData.fromJson(json['data'] as Map<String, dynamic>)
					: null,
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'status': status,
			'message': message,
			'data': data?.toJson(),
		};
	}

	@override
	List<Object?> get props => [status, message, data];
}
