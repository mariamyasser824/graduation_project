import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rewarding_kids/features/auth/cubit/forget_password_state.dart';
import 'package:rewarding_kids/features/auth/data/services/auth_service.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthService _authService = AuthService();

  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  // ✅ الصح
  Future<void> forgotPassword(String email) async {
    emit(ForgetPasswordLoading());
    try {
      final response = await _authService.forgotPassword(email: email);
      if (response is Map<String, dynamic> && response["succeeded"] == true) {
        final userId = response["data"]["userId"];
        emit(ForgetPasswordSuccess(userId));
      } else {
        emit(
          ForgetPasswordError(response["message"] ?? "Something went wrong"),
        );
      }
    } catch (e) {
      emit(ForgetPasswordError(e.toString()));
    }
  }
}
