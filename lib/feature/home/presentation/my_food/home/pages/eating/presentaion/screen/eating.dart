import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors.dart';
import '../../../../../core/utils/text_style.dart';
import '../../../../widget/food_details_screen.dart';
import '../../../../widget/food_form_screen.dart';
import '../../data/cubit/food_cubit.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('أكلاتي', style: gettitlestyle(context, color: Appcolor.primary)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text('خطأ: ${state.error}'));
            }
            if (state.foods.isEmpty) {
              return const Center(child: Text('لا توجد أطعمة متاحة'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.foods.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final food = state.foods[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 3,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => FoodDetailsScreen(food: food)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    'https://mangamediaa.com/house-food/public/${food.image}',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        const Icon(Icons.broken_image, size: 50),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        food.name,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${food.offerPrice} م.ج',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: List.generate(5, (i) {
                                          return Icon(
                                            Icons.star,
                                            size: 16,
                                            color: i < 4 ? Colors.amber : Colors.grey.shade300,
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                              value: context.read<FoodCubit>(),
                                              child: FoodFormScreen(food: food),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text('تأكيد الحذف'),
                                            content: Text('هل أنت متأكد من حذف ${food.name}؟'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('إلغاء'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context.read<FoodCubit>().deleteFood(food.id);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('حذف'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<FoodCubit>(),
                            child: const FoodFormScreen(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text('أضف المزيد', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
