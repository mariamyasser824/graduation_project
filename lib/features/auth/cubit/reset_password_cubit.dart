import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rewarding_kids/features/auth/cubit/reset_password_state.dart';
import 'package:rewarding_kids/features/auth/data/services/auth_service.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthService _authService = AuthService();

  ResetPasswordCubit() : super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String userId,
    required String otp,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());

    final response = await _authService.resetPassword(
      userId: userId,
      otp: otp,
      token: 'null',
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    if (response["succeeded"] == true) {
      emit(ResetPasswordSuccess());
    } else {
      emit(ResetPasswordError(response["message"] ?? "Reset failed"));
    }
  }
}
