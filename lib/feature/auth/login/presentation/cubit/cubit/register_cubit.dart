import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodia_chef/feature/auth/login/data/repo/register_repo.dart';
import 'package:foodia_chef/feature/auth/login/presentation/cubit/cubit/register_state.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/models/failures.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerRepository) : super(RegisterInitial());
  final RegisterRepo registerRepository;

  Future<void> register({
    required String name,
    required String phone,
    required String password,
    required String confirmPassword,
    required String bio,
    required XFile? image,
    required String email,
  }) async {
    // التحقق من الصورة
    if (image == null) {
      emit(RegisterError('Please select an image.'));
      return;
    }

    // التحقق من أن جميع الحقول مكتملة
    if (name.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        bio.isEmpty) {
      emit(RegisterError('All fields are required.'));
      return;
    }

    // التحقق من تطابق كلمة المرور
    if (password != confirmPassword) {
      emit(RegisterError('Password and confirm password must match.'));
      return;
    }

    emit(RegisterLoading());

    // إرسال البيانات إلى الريبو
    final result = await registerRepository.register(
      name: name,
      phone: phone,
      password: password,
      passwordConfirmation: confirmPassword,
      bio: bio,
      image: image,
      email: email,
    );

    // التعامل مع النتيجة
    result.fold((failure) {
      if (failure is ServerFailure) {
        emit(RegisterError('Server error: ${failure.message}'));
      } else if (failure is NetworkFailure) {
        emit(RegisterError('Network error: ${failure.message}'));
      } else if (failure is AuthFailure) {
        emit(RegisterError('Authentication error: ${failure.message}'));
      } else if (failure is VerificationFailure) {
        emit(RegisterError('Verification error: ${failure.message}'));
      }
    }, (user) {
      emit(RegisterSuccess(user: user));
    });
  }
}
