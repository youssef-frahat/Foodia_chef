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
    emit(RegisterLoading());
    final result = await registerRepository.register(
      name: name,
      phone: phone,
      password: password,
      passwordConfirmation: confirmPassword,
      bio: bio,
      image: image!,
      email: email,
    );
    result.fold((failure) {
      if (failure is ServerFailure) {
        emit(
          RegisterError(
            failure.message,
          ),
        );
      }
      if (failure is NetworkFailure) {
        emit(
          RegisterError(
            failure.message,
          ),
        );
      }
      if (failure is AuthFailure) {
        emit(
          RegisterError(
            failure.message,
          ),
        );
      }
      if (failure is VerificationFailure) {
        emit(
          RegisterError(
            failure.message,
          ),
        );
      }
    }, (user) async {
      emit(
        RegisterSuccess(user: user),
      );
    });
  }
}
