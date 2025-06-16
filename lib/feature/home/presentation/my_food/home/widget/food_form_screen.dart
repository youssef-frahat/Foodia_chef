import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../pages/eating/data/cubit/food_cubit.dart';
import '../pages/eating/data/model/food_model.dart';

class FoodFormScreen extends StatefulWidget {
  final Food? food;

  const FoodFormScreen({super.key, this.food});

  @override
  _FoodFormScreenState createState() => _FoodFormScreenState();
}

class _FoodFormScreenState extends State<FoodFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _offerPriceController;
  late TextEditingController _preparationTimeController;
  String _status = 'active';
  String _foodType = 'full';
  int _categoryId = 1;
  int _chefId = 1;
  File? _imageFile;
  String? _errorMessage;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.food?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.food?.description ?? '');
    _priceController =
        TextEditingController(text: widget.food?.price.toString() ?? '');
    _offerPriceController = TextEditingController(
        text: widget.food?.offerPrice.toString() ?? '');
    _preparationTimeController = TextEditingController(
        text: widget.food?.preparationTime.toString() ?? '');

    if (widget.food != null) {
      _status = widget.food!.status;
      _foodType = widget.food!.foodType!;
      _categoryId = widget.food!.category.id;
      _chefId = widget.food!.chef.id;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _offerPriceController.dispose();
    _preparationTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _errorMessage = null;
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (widget.food == null && _imageFile == null) {
        setState(() => _errorMessage = 'الرجاء اختيار صورة');
        return;
      }

      setState(() => _isSubmitting = true);

      final foodData = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.tryParse(_priceController.text) ?? 0,
        'offer_price': _offerPriceController.text.isEmpty
            ? double.tryParse(_priceController.text) ?? 0
            : double.tryParse(_offerPriceController.text) ?? 0,
        'preparation_time': int.tryParse(_preparationTimeController.text) ?? 0,
        'status': _status,
        'food_type': _foodType,
        'category_id': _categoryId,
        'chef_id': _chefId,
      };

      try {
        if (widget.food == null) {
          await context.read<FoodCubit>().createFood(foodData, _imageFile);
        } else {
          await context.read<FoodCubit>().updateFood(widget.food!.id, foodData, _imageFile);
        }

        if (context.mounted) Navigator.pop(context);
      } catch (e) {
        setState(() {
          _errorMessage = "حدث خطأ أثناء الحفظ، حاول مرة أخرى";
        });
      } finally {
        setState(() => _isSubmitting = false);
      }
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: _imageFile != null || widget.food != null
                          ? Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: _imageFile != null
                                      ? FileImage(_imageFile!)
                                      : NetworkImage(
                                          'https://mangamediaa.com/house-food/public/${widget.food!.image}',
                                        ) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(12),
                              dashPattern: [6, 3],
                              color: Colors.orange,
                              strokeWidth: 2,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined,
                                          size: 30, color: Colors.orange),
                                      SizedBox(height: 4),
                                      Text(
                                        'إضافة صورة',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'اختيار',
                                        style: TextStyle(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            decoration: _inputDecoration("اسم الأكلة"),
                            validator: (val) =>
                                val!.isEmpty ? 'الرجاء إدخال الاسم' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: 3,
                            decoration:
                                _inputDecoration('الوصف (المكونات/طريقة التحضير)'),
                            validator: (val) =>
                                val!.isEmpty ? 'الرجاء إدخال الوصف' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration("السعر"),
                            validator: (val) =>
                                val!.isEmpty ? 'الرجاء إدخال السعر' : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _offerPriceController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration("السعر المخفض (اختياري)"),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _preparationTimeController,
                            keyboardType: TextInputType.number,
                            decoration: _inputDecoration("⏱️ أضف وقت التحضير"),
                            validator: (val) =>
                                val!.isEmpty ? 'الرجاء إدخال الوقت' : null,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: _foodType,
                            decoration: _inputDecoration("حدد التسوية"),
                            items: const [
                              DropdownMenuItem(
                                value: 'full',
                                child: Text('تسوية كاملة'),
                              ),
                              DropdownMenuItem(
                                value: 'half',
                                child: Text('نصف تسوية'),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() => _foodType = val!);
                            },
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<int>(
                            value: _categoryId,
                            decoration: _inputDecoration("حدد القسم"),
                            items: const [
                              DropdownMenuItem(
                                  value: 1, child: Text('أكلات رمضانية')),
                              DropdownMenuItem(value: 2, child: Text('طبيخ')),
                              DropdownMenuItem(
                                  value: 3, child: Text('أكلات شعبية')),
                              DropdownMenuItem(
                                  value: 4, child: Text('حلويات رمضانية')),
                            ],
                            onChanged: (val) {
                              setState(() => _categoryId = val!);
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _isSubmitting ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _isSubmitting
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(widget.food == null ? "إضافة" : "تعديل"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
