import 'package:equatable/equatable.dart';

class GetChefProfileModel extends Equatable {
  final Chef chef;
  final ChefStatistics chefStatistics;

  const GetChefProfileModel({
    required this.chef,
    required this.chefStatistics,
  });

  factory GetChefProfileModel.fromJson(Map<String, dynamic> json) {
    return GetChefProfileModel(
      chef: Chef.fromJson(json['chef']),
      chefStatistics: ChefStatistics.fromJson(json['chef_statistics']),
    );
  }

  @override
  List<Object?> get props => [chef, chefStatistics];
}

class Chef extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String otp;
  final int isVerify;
  final String image;
  final String wallet;
  final int countSubscribe;
  final String bio;
  final int totalOrder;
  final String? fcmToken;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Chef({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.otp,
    required this.isVerify,
    required this.image,
    required this.wallet,
    required this.countSubscribe,
    required this.bio,
    required this.totalOrder,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chef.fromJson(Map<String, dynamic> json) {
    return Chef(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      otp: json['otp'],
      isVerify: json['is_verify'],
      image: json['image'],
      wallet: json['wallet'],
      countSubscribe: json['countSubscribe'],
      bio: json['bio'],
      totalOrder: json['totalOrder'],
      fcmToken: json['fcm_token'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        otp,
        isVerify,
        image,
        wallet,
        countSubscribe,
        bio,
        totalOrder,
        fcmToken,
        createdAt,
        updatedAt,
      ];
}

class ChefStatistics extends Equatable {
  final int totalCompletedOrders;
  final int totalDishes;
  final int totalFollowers;

  const ChefStatistics({
    required this.totalCompletedOrders,
    required this.totalDishes,
    required this.totalFollowers,
  });

  factory ChefStatistics.fromJson(Map<String, dynamic> json) {
    return ChefStatistics(
      totalCompletedOrders: json['total_completed_orders'],
      totalDishes: json['total_dishes'],
      totalFollowers: json['total_followers'],
    );
  }

  @override
  List<Object?> get props =>
      [totalCompletedOrders, totalDishes, totalFollowers];
}
