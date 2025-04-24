import 'dart:io';
import 'package:dio/dio.dart';
import 'package:foodia_chef/core/app_config/app_strings.dart';

class RegisterApi {
  final Dio _dio = Dio();

  static const String _baseUrl =
      'https://mangamediaa.com/house-food/public/api/chef';

  // API to register a new chef
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String bio,
    required File? profileImage,
  }) async {
    final url = '$_baseUrl/register';

    try {
      final FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'bio': bio,
        if (profileImage != null)
          'profile_image': await MultipartFile.fromFile(profileImage.path),
      });

      final response = await _dio.post(url, data: formData);

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(AppStrings.registrationFailed);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // API to verify OTP
  Future<Map<String, dynamic>> verifyOtp({
    required String otpCode,
    required String phone,
  }) async {
    final url = '$_baseUrl/verify-otp';

    try {
      final response = await _dio.post(url, data: {
        'otp': otpCode,
        'phone': phone,
      });

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(AppStrings.YourVerificationCodeFaild);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // API to send OTP to a phone number
  Future<Map<String, dynamic>> sendOtp({
    required String phone,
  }) async {
    final url = '$_baseUrl/send-otp';

    try {
      final response = await _dio.post(url, data: {
        'phone': phone,
      });

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(AppStrings.otpSendingFailed);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
