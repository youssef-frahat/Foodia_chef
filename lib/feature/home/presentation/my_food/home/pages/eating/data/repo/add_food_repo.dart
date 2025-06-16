// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:foodia_chef/core/network/api_services.dart';
import 'dart:io';

import '../model/food_model.dart';

class FoodRepository {
  static const String _baseUrl =
      'https://mangamediaa.com/house-food/public/api/chef/foods';
  static const String _token =
      'Bearer 287|rT11pZs4vWclXGPfhJdrbQAMlLHcJEjHwxNTEgv2c6b3fa0c';
  final Dio _dio;

  FoodRepository(ApiService apiService)
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          headers: {
            'Authorization': _token,
            'Accept': 'application/json',
            'Cache-Control': 'no-cache', // Prevent caching
          },
          connectTimeout: Duration(seconds: 30),
          receiveTimeout: Duration(seconds: 30),
        ),
      );

  Future<FoodResponse> getFoods() async {
    print('START: Fetching foods from API');
    try {
      final response = await _dio.get('');
      print(
        'SUCCESS: Foods fetched - Status Code: ${response.statusCode}, Data: ${response.data}',
      );
      final foodResponse = FoodResponse.fromJson(response.data);
      print(
        'PARSED: Fetched ${foodResponse.data.length} foods with IDs: ${foodResponse.data.map((food) => food.id).toList()}',
      );
      return foodResponse;
    } catch (e) {
      print('ERROR: Failed to fetch foods - Error: $e');
      throw Exception('Failed to load foods: $e');
    }
  }

  Future<void> createFood(
    Map<String, dynamic> foodData,
    File? imageFile,
  ) async {
    print(
      'START: Creating food - FoodData: $foodData, HasImage: ${imageFile != null}',
    );
    try {
      FormData formData = FormData.fromMap({
        ...foodData,
        if (imageFile != null)
          'images': await MultipartFile.fromFile(imageFile.path),
      });
      print(
        'SENDING: FormData fields: ${formData.fields}, Files: ${formData.files}',
      );
      final response = await _dio.post('', data: formData);
      print(
        'RESPONSE: Create food - Status Code: ${response.statusCode}, Response: ${response.data}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['status'] == true) {
          print('SUCCESS: Food created successfully - Data: ${response.data}');
          return;
        } else {
          print(
            'ERROR: API returned success status code but status is false - Response: ${response.data}',
          );
          throw Exception(
            'Failed to create food: ${response.data['message'] ?? 'Unknown error'}',
          );
        }
      } else {
        print(
          'ERROR: Invalid status code - Status Code: ${response.statusCode}, Response: ${response.data}',
        );
        throw Exception(
          'Failed to create food: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      print(
        'ERROR: DioException in createFood - Status Code: ${e.response?.statusCode}, Response: ${e.response?.data}, Error: ${e.message}',
      );
      throw Exception(
        'Failed to create food: ${e.response?.statusCode} - ${e.response?.data}',
      );
    } catch (e) {
      print('ERROR: Unexpected error in createFood - Error: $e');
      throw Exception('Failed to create food: $e');
    }
  }

  Future<void> updateFood(
    int id,
    Map<String, dynamic> foodData,
    File? imageFile,
  ) async {
    print(
      'START: Updating food ID: $id - FoodData: $foodData, HasImage: ${imageFile != null}',
    );
    try {
      FormData formData = FormData.fromMap({
        ...foodData,
        if (imageFile != null)
          'images': await MultipartFile.fromFile(imageFile.path),
      });
      print(
        'SENDING: FormData fields: ${formData.fields}, Files: ${formData.files}',
      );
      final response = await _dio.put('/$id', data: formData);
      print(
        'SUCCESS: Food updated - Status Code: ${response.statusCode}, Response: ${response.data}',
      );
      if (response.statusCode != 200) {
        print(
          'ERROR: Failed to update food - Status Code: ${response.statusCode}, Response: ${response.data}',
        );
        throw Exception(
          'Failed to update food: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      print(
        'ERROR: DioException in updateFood - Status Code: ${e.response?.statusCode}, Response: ${e.response?.data}, Error: ${e.message}',
      );
      throw Exception(
        'Failed to update food: ${e.response?.statusCode} - ${e.response?.data}',
      );
    } catch (e) {
      print('ERROR: Unexpected error in updateFood - Error: $e');
      throw Exception('Failed to update food: $e');
    }
  }

  Future<void> deleteFood(int id) async {
    print('START: Deleting food ID: $id');
    try {
      final response = await _dio.delete('/$id');
      print(
        'SUCCESS: Food deleted - Status Code: ${response.statusCode}, Response: ${response.data}',
      );
      if (response.statusCode != 200) {
        print(
          'ERROR: Failed to delete food - Status Code: ${response.statusCode}, Response: ${response.data}',
        );
        throw Exception(
          'Failed to delete food: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      print(
        'ERROR: DioException in deleteFood - Status Code: ${e.response?.statusCode}, Response: ${e.response?.data}, Error: ${e.message}',
      );
      throw Exception(
        'Failed to delete food: ${e.response?.statusCode} - ${e.response?.data}',
      );
    } catch (e) {
      print('ERROR: Unexpected error in deleteFood - Error: $e');
      throw Exception('Failed to delete food: $e');
    }
  }
}
