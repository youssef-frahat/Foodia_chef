import 'package:equatable/equatable.dart';

import 'data.dart';

class GetUserProfileModel extends Equatable {
  final bool? status;
  final String? message;
  final UserDataModel? data;

  const GetUserProfileModel({this.status, this.message, this.data});

  factory GetUserProfileModel.fromJson(Map<String, dynamic> json) {
    return GetUserProfileModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data:
          json['data'] == null
              ? null
              : UserDataModel.fromJson(json['data'] as Map<String, dynamic>),
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
