import 'package:equatable/equatable.dart';

class RegisterData extends Equatable {
  final String? name;
  final String? phone;
  final String? email;
  final String? bio;
  final int? otp;
  final String? image;
  final String? token;
  final dynamic wallet;
  final dynamic countSubscribe;
  final dynamic totalOrder;

  const RegisterData({
    this.name,
    this.phone,
    this.email,
    this.bio,
    this.otp,
    this.image,
    this.token,
    this.wallet,
    this.countSubscribe,
    this.totalOrder,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        bio: json['bio'] as String?,
        otp: json['otp'] is int
            ? json['otp']
            : int.tryParse(json['otp']?.toString() ?? ''),
        image: json['image'] as String?,
        token: json['token'] as String?,
        wallet: json['wallet'],
        countSubscribe: json['countSubscribe'],
        totalOrder: json['totalOrder'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'bio': bio,
        'otp': otp,
        'image': image,
        'token': token,
        'wallet': wallet,
        'countSubscribe': countSubscribe,
        'totalOrder': totalOrder,
      };

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        bio,
        otp,
        image,
        token,
        wallet,
        countSubscribe,
        totalOrder,
      ];
}
