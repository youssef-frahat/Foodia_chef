import 'package:equatable/equatable.dart';

import 'data.dart';

class EditUserProfileModel extends Equatable {
  final bool? status;
  final String? message;
  final Data? data;

  const EditUserProfileModel({this.status, this.message, this.data});

  factory EditUserProfileModel.fromJson(Map<String, dynamic> json) {
    return EditUserProfileModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
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
