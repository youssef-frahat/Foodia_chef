import 'package:flutter/material.dart';

import '../pages/eating/data/model/food_model.dart';

class FoodDetailsScreen extends StatelessWidget {
  final Food food;

  const FoodDetailsScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE28800),
      appBar: AppBar(
        title: Text(food.name, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.orange),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://mangamediaa.com/house-food/public/${food.image}',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            )),
                    const SizedBox(height: 10),
                    Text(food.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16)),
                    const Divider(height: 30),
                    Text('السعر: ${food.price} جنيه',
                        style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold)),
                    if (food.offerPrice != food.price)
                      Text('سعر العرض: ${food.offerPrice} جنيه',
                          style: const TextStyle(color: Colors.red, fontSize: 16)),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.timer, 'وقت التحضير: ${food.preparationTime} دقيقة'),
                    _buildInfoRow(Icons.info_outline, 'الحالة: ${food.status == 'active' ? 'نشط' : 'غير نشط'}'),
                    _buildInfoRow(Icons.restaurant_menu, 'نوع الطعام: ${food.foodType == 'full' ? 'كامل' : 'نصف'}'),
                    _buildInfoRow(Icons.category, 'الفئة: ${food.category.name}'),
                    _buildInfoRow(Icons.person, 'الشيف: ${food.chef.name}'),
                    _buildInfoRow(Icons.star, 'التقييم: ${food.rating ?? 'غير متوفر'}'),
                    _buildInfoRow(Icons.date_range, 'تاريخ الإنشاء: ${food.createdAt}'),
                    _buildInfoRow(Icons.update, 'آخر تحديث: ${food.updatedAt}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16, color: Colors.black87))),
        ],
      ),
    );
  }
}
