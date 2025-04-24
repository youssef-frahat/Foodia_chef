// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../../core/app_config/app_strings.dart';
// import '../../../../../../core/network/register_api_services.dart';
// import 'register_state.dart';

// class RegisterCubit extends Cubit<RegisterState> {

//   RegisterCubit(this._registerApi) : super(RegisterInitial());

//   // Method to send OTP
//   void sendOtp({required String phone}) async {
//     emit(RegisterLoading());  // Show loading state while sending OTP
//     try {
//       final response = await _registerApi.sendOtp(phone: phone);
//       if (response['success'] == true) {
//         emit(RegisterOtpSent(message: AppStrings.otpSent));
//       } else {
//         emit(RegisterError(
//           error: response['message'] ?? AppStrings.otpSendingFailed,
//           source: RegisterErrorSource.sendOtp,
//         ));
//       }
//     } catch (e) {
//       String errorMessage = _getErrorMessage(e);
//       emit(RegisterError(
//         error: errorMessage,
//         source: RegisterErrorSource.sendOtp,
//       ));  // Handle API or connection errors
//     }
//   }

//   // Method to verify OTP
//   void verifyOtp({required String otpCode, required String phone}) async {
//     emit(RegisterLoading());  // Show loading state while verifying OTP
//     try {
//       final response = await _registerApi.verifyOtp(otpCode: otpCode, phone: phone);
//       if (response['success'] == true) {
//         emit(RegisterSuccess(message: AppStrings.otpVerificationSuccessful));
//       } else {
//         emit(RegisterError(
//           error: response['message'] ?? AppStrings.otpVerificationFailed,
//           source: RegisterErrorSource.verifyOtp,
//         ));
//       }
//     } catch (e) {
//       String errorMessage = _getErrorMessage(e);
//       emit(RegisterError(
//         error: errorMessage,
//         source: RegisterErrorSource.verifyOtp,
//       ));  // Handle API or connection errors
//     }
//   }

//   // Method to handle user registration
//   void register({
//     required String name,
//     required String email,
//     required String phone,
//     required String password,
//     required String bio,
//     required File? profileImage,
//     required String password_confirmation,
//   }) async {
//     emit(RegisterLoading());  // Show loading state while registering
//     try {
//       final response = await _registerApi.register(
//         name: name,
//         email: email,
//         phone: phone,
//         password: password,
//         bio: bio,
//         profileImage: profileImage,
//         password_confirmation: password_confirmation,
//       );
//       if (response['success'] == true) {
//         emit(RegisterSuccess(message: AppStrings.registrationSuccessful));
//       } else {
//         emit(RegisterError(
//           error: response['message'] ?? AppStrings.registrationFailed,
//           source: RegisterErrorSource.register,
//         ));
//       }
//     } catch (e) {
//       String errorMessage = _getErrorMessage(e);
//       emit(RegisterError(
//         error: errorMessage,
//         source: RegisterErrorSource.register,
//       ));  // Handle API or connection errors
//     }
//   }

//   // A helper method to extract error message from an exception
//   String _getErrorMessage(dynamic e) {
//     if (e is DioException) {
//       if (e.response != null) {
//         // Checking if the response contains a message
//         return e.response?.data['message'] ?? AppStrings.genericError;
//       }
//     }
//     return AppStrings.genericError; // A fallback error message
//   }
// }
