class LogoutModel {
  bool? status;
  String? message;
  dynamic data;

  LogoutModel({this.status, this.message, this.data});

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    status: json['status'] as bool?,
    message: json['message'] as String?,
    data: json['data'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data,
  };
}
