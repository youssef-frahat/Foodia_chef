// // ignore_for_file: avoid_print

// class FoodResponse {
//   final List<Food> data;

//   FoodResponse({required this.data});

//   factory FoodResponse.fromJson(Map<String, dynamic> json) {
//     try {
//       var list = json['data'] as List;
//       List<Food> foodsList = list.map((i) => Food.fromJson(i)).toList();
//       return FoodResponse(data: foodsList);
//     } catch (e) {
//       print('ERROR: Failed to parse FoodResponse - JSON: $json, Error: $e');
//       rethrow;
//     }
//   }
// }

// class Food {
//   final int id;
//   final Category category;
//   final Chef chef;
//   final List<String> images;
//   final String name;
//   final String description;
//   final String image;
//   final double offerPrice;
//   final double price;
//   final String status;
//   final int preparationTime;
//   final double? rating;
//   final String? foodType;
//   final String createdAt;
//   final String updatedAt;

//   Food({
//     required this.id,
//     required this.category,
//     required this.chef,
//     required this.images,
//     required this.name,
//     required this.description,
//     required this.image,
//     required this.offerPrice,
//     required this.price,
//     required this.status,
//     required this.preparationTime,
//     this.rating,
//     this.foodType,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Food.fromJson(Map<String, dynamic> json) {
//     try {
//       return Food(
//         id: int.parse(json['id'].toString()), // Safe parsing
//         category: Category.fromJson(json['category']),
//         chef: Chef.fromJson(json['chef']),
//          images: List<String>.from(json['images'] ?? []),
//         name: json['name'] as String,
//         description: json['description'] as String,
//         image: json['image'] as String,
//         offerPrice: double.parse(json['offer_price'].toString()),
//         price: double.parse(json['price'].toString()),
//         status: json['status'] as String,
//         preparationTime: int.parse(
//           json['preparation_time'].toString(),
//         ), // Safe parsing
//         rating:
//             json['rating'] != null
//                 ? double.parse(json['rating'].toString())
//                 : null,
//         foodType: json['food_type'] as String?,
//         createdAt: json['created_at'] as String,
//         updatedAt: json['updated_at'] as String,
//       );
//     } catch (e) {
//       print('ERROR: Failed to parse Food - JSON: $json, Error: $e');
//       rethrow;
//     }
//   }
// }

// class Category {
//   final int id;
//   final String name;
//   final String image;

//   Category({required this.id, required this.name, required this.image});

//   factory Category.fromJson(Map<String, dynamic> json) {
//     try {
//       return Category(
//         id: int.parse(json['id'].toString()), // Safe parsing
//         name: json['name'] as String,
//         image: json['image'] as String,
//       );
//     } catch (e) {
//       print('ERROR: Failed to parse Category - JSON: $json, Error: $e');
//       rethrow;
//     }
//   }
// }

// class Chef {
//   final int id;
//   final String name;
//   final String phone;
//   final String email;
//   final int countSubscribe;
//   final double wallet;
//   final String bio;
//   final int totalOrder;
//   final int otp;
//   final String image;
//   final String? token;

//   Chef({
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.email,
//     required this.countSubscribe,
//     required this.wallet,
//     required this.bio,
//     required this.totalOrder,
//     required this.otp,
//     required this.image,
//     this.token,
//   });

//   factory Chef.fromJson(Map<String, dynamic> json) {
//     try {
//       return Chef(
//         id: int.parse(json['id'].toString()), // Safe parsing
//         name: json['name'] as String,
//         phone: json['phone'] as String,
//         email: json['email'] as String,
//         countSubscribe: int.parse(
//           json['countSubscribe'].toString(),
//         ), // Safe parsing
//         wallet: double.parse(json['wallet'].toString()),
//         bio: json['bio'] as String,
//         totalOrder: int.parse(json['totalOrder'].toString()), // Safe parsing
//         otp: int.parse(json['otp'].toString()), // Safe parsing
//         image: json['image'] as String,
//         token: json['token'] as String?,
//       );
//     } catch (e) {
//       print('ERROR: Failed to parse Chef - JSON: $json, Error: $e');
//       rethrow;
//     }
//   }
// }



// ignore_for_file: avoid_print

class FoodResponse {
  final List<Food> data;

  FoodResponse({required this.data});

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    try {
      var list = json['data'] as List;
      List<Food> foodsList = list.map((i) => Food.fromJson(i)).toList();
      return FoodResponse(data: foodsList);
    } catch (e) {
      print('ERROR: Failed to parse FoodResponse - JSON: $json, Error: $e');
      rethrow;
    }
  }
}

class Food {
  final int id;
  final Category category;
  final Chef chef;
  final List<String> images;
  final String name;
  final String description;
  final String image;
  final double offerPrice;
  final double price;
  final String status;
  final int preparationTime;
  final double? rating;
  final String? foodType;
  final String createdAt;
  final String updatedAt;

  Food({
    required this.id,
    required this.category,
    required this.chef,
    required this.images,
    required this.name,
    required this.description,
    required this.image,
    required this.offerPrice,
    required this.price,
    required this.status,
    required this.preparationTime,
    this.rating,
    this.foodType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    try {
      return Food(
        id: int.tryParse(json['id'].toString()) ?? 0,
        category: Category.fromJson(json['category'] ?? {}),
        chef: Chef.fromJson(json['chef'] ?? {}),
        images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
        name: json['name']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
        image: json['image']?.toString() ?? '',
        offerPrice: double.tryParse(json['offer_price'].toString()) ?? 0.0,
        price: double.tryParse(json['price'].toString()) ?? 0.0,
        status: json['status']?.toString() ?? '',
        preparationTime: int.tryParse(json['preparation_time'].toString()) ?? 0,
        rating: json['rating'] != null ? double.tryParse(json['rating'].toString()) : null,
        foodType: json['food_type']?.toString(),
        createdAt: json['created_at']?.toString() ?? '',
        updatedAt: json['updated_at']?.toString() ?? '',
      );
    } catch (e) {
      print('ERROR: Failed to parse Food - JSON: $json, Error: $e');
      rethrow;
    }
  }
}

class Category {
  final int id;
  final String name;
  final String image;

  Category({required this.id, required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    try {
      return Category(
        id: int.tryParse(json['id'].toString()) ?? 0,
        name: json['name']?.toString() ?? '',
        image: json['image']?.toString() ?? '',
      );
    } catch (e) {
      print('ERROR: Failed to parse Category - JSON: $json, Error: $e');
      rethrow;
    }
  }
}

class Chef {
  final int id;
  final String name;
  final String phone;
  final String email;
  final int countSubscribe;
  final double wallet;
  final String bio;
  final int totalOrder;
  final int otp;
  final String image;
  final String? token;

  Chef({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.countSubscribe,
    required this.wallet,
    required this.bio,
    required this.totalOrder,
    required this.otp,
    required this.image,
    this.token,
  });

  factory Chef.fromJson(Map<String, dynamic> json) {
    try {
      return Chef(
        id: int.tryParse(json['id'].toString()) ?? 0,
        name: json['name']?.toString() ?? '',
        phone: json['phone']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        countSubscribe: int.tryParse(json['countSubscribe'].toString()) ?? 0,
        wallet: double.tryParse(json['wallet'].toString()) ?? 0.0,
        bio: json['bio']?.toString() ?? '',
        totalOrder: int.tryParse(json['totalOrder'].toString()) ?? 0,
        otp: int.tryParse(json['otp'].toString()) ?? 0,
        image: json['image']?.toString() ?? '',
        token: json['token']?.toString(),
      );
    } catch (e) {
      print('ERROR: Failed to parse Chef - JSON: $json, Error: $e');
      rethrow;
    }
  }
}
