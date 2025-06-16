// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';

import '../model/food_model.dart';
import '../repo/add_food_repo.dart';

class FoodState {
  final bool isLoading;
  final List<Food> foods;
  final String? error;
  final bool isSuccess;

  FoodState({
    this.isLoading = false,
    this.foods = const [],
    this.error,
    this.isSuccess = false,
  });
}

class FoodCubit extends Cubit<FoodState> {
  final FoodRepository repository;

  FoodCubit(this.repository) : super(FoodState()) {
    print('INIT: FoodCubit initialized');
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    print('START: Cubit fetchFoods');
    emit(FoodState(isLoading: true));
    try {
      final response = await repository.getFoods();
      print(
        'SUCCESS: Cubit fetched ${response.data.length} foods with IDs: ${response.data.map((food) => food.id).toList()}',
      );
      emit(FoodState(foods: response.data));
    } catch (e) {
      print('ERROR: Cubit fetchFoods failed - Error: $e');
      emit(FoodState(error: e.toString()));
    }
  }

  Future<void> createFood(
    Map<String, dynamic> foodData,
    File? imageFile,
  ) async {
    print(
      'START: Cubit createFood - FoodData: $foodData, HasImage: ${imageFile != null}',
    );
    emit(FoodState(isLoading: true));
    try {
      await repository.createFood(foodData, imageFile);
      print('SUCCESS: Cubit created food');
      await Future.delayed(
        Duration(milliseconds: 500),
      ); // Small delay to ensure API sync
      await fetchFoods();
      emit(FoodState(foods: state.foods, isSuccess: true));
    } catch (e) {
      print('ERROR: Cubit createFood failed - Error: $e');
      emit(FoodState(error: e.toString()));
    }
  }

  Future<void> updateFood(
    int id,
    Map<String, dynamic> foodData,
    File? imageFile,
  ) async {
    print(
      'START: Cubit updateFood ID: $id - FoodData: $foodData, HasImage: ${imageFile != null}',
    );
    emit(FoodState(isLoading: true));
    try {
      await repository.updateFood(id, foodData, imageFile);
      print('SUCCESS: Cubit updated food ID: $id');
      await Future.delayed(Duration(milliseconds: 500)); // Small delay
      await fetchFoods();
      emit(FoodState(foods: state.foods, isSuccess: true));
    } catch (e) {
      print('ERROR: Cubit updateFood failed - Error: $e');
      emit(FoodState(error: e.toString()));
    }
  }

  Future<void> deleteFood(int id) async {
    print('START: Cubit deleteFood ID: $id');
    emit(FoodState(isLoading: true));
    try {
      await repository.deleteFood(id);
      print('SUCCESS: Cubit deleted food ID: $id');
      await Future.delayed(Duration(milliseconds: 500)); // Small delay
      await fetchFoods();
      emit(FoodState(foods: state.foods, isSuccess: true));
    } catch (e) {
      print('ERROR: Cubit deleteFood failed - Error: $e');
      emit(FoodState(error: e.toString()));
    }
  }

}
