import 'package:equatable/equatable.dart';

class GetOrdersModel extends Equatable {
  final String status;
  final int itemsCount;
  final List<OrderItem> orderItems;
  final ChefStatistics chefStatistics;

  const GetOrdersModel({
    required this.status,
    required this.itemsCount,
    required this.orderItems,
    required this.chefStatistics,
  });

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) {
    return GetOrdersModel(
      status: json['status'],
      itemsCount: json['items_count'],
      orderItems: List<OrderItem>.from(
          json['order_items'].map((x) => OrderItem.fromJson(x))),
      chefStatistics: ChefStatistics.fromJson(json['chef_statistics']),
    );
  }

  @override
  List<Object?> get props => [status, itemsCount, orderItems, chefStatistics];
}

class OrderItem extends Equatable {
  final int id;
  final int orderId;
  final int foodId;
  final int chefId;
  final int qty;
  final String subtotal;
  final String chefStatus;
  final String chefStatusUpdatedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Order order;
  final Food food;
  final Chef chef;

  const OrderItem({
    required this.id,
    required this.orderId,
    required this.foodId,
    required this.chefId,
    required this.qty,
    required this.subtotal,
    required this.chefStatus,
    required this.chefStatusUpdatedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.order,
    required this.food,
    required this.chef,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      foodId: json['food_id'],
      chefId: json['chef_id'],
      qty: json['qty'],
      subtotal: json['subtotal'],
      chefStatus: json['chef_status'],
      chefStatusUpdatedAt: json['chef_status_updated_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      order: Order.fromJson(json['order']),
      food: Food.fromJson(json['food']),
      chef: Chef.fromJson(json['chef']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        foodId,
        chefId,
        qty,
        subtotal,
        chefStatus,
        chefStatusUpdatedAt,
        createdAt,
        updatedAt,
        order,
        food,
        chef,
      ];
}

class Order extends Equatable {
  final int id;
  final int userId;
  final String paid;
  final User user;

  const Order({
    required this.id,
    required this.userId,
    required this.paid,
    required this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      paid: json['paid'],
      user: User.fromJson(json['user']),
    );
  }

  @override
  List<Object?> get props => [id, userId, paid, user];
}

class User extends Equatable {
  final int id;
  final String name;
  final String phone;
  final String? image;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  @override
  List<Object?> get props => [id, name, phone, image];
}

class Food extends Equatable {
  final int id;
  final String name;
  final String image;

  const Food({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  @override
  List<Object?> get props => [id, name, image];
}

class Chef extends Equatable {
  final int id;
  final String name;
  final String bio;
  final String image;

  const Chef({
    required this.id,
    required this.name,
    required this.bio,
    required this.image,
  });

  factory Chef.fromJson(Map<String, dynamic> json) {
    return Chef(
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
      image: json['image'],
    );
  }

  @override
  List<Object?> get props => [id, name, bio, image];
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
