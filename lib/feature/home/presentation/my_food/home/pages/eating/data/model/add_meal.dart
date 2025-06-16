class AddMeal {
  String? name;
  String? description;
  String? price;
  String? offerPrice;
  String? image;
  String? preparationTime;
  int? categoryId;
  String? status;

  AddMeal({
    this.name,
    this.description,
    this.price,
    this.offerPrice,
    this.image,
    this.preparationTime,
    this.categoryId,
    this.status,
  });

  factory AddMeal.fromJson(Map<String, dynamic> json) {
    String? parsedImage;

    if (json['image'] is String) {
      parsedImage = json['image'];
    } else if (json['image'] is List && json['image'].isNotEmpty) {
      parsedImage = json['image'][0];
    } else {
      parsedImage = null;
    }

    if (parsedImage != null && !parsedImage.startsWith('http')) {
      parsedImage = 'https://mangamediaa.com/house-food/public/$parsedImage';
    }

    return AddMeal(
      name: json['name']?.toString(),
      description: json['description']?.toString(),
      price: json['price']?.toString(),
      offerPrice: json['offer_price']?.toString(),
      image: parsedImage,
      preparationTime: json['preparation_time']?.toString(),
      categoryId: json['category_id']?.toint(),
      status: json['status']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'offer_price': offerPrice,
    'image': image,
    'preparation_time': preparationTime,
    'category_id': categoryId,
    'status': status,
  };
}
