import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/network/api_error.dart';
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
    required String email,
  }) async {
    emit(ResetPasswordLoading());
    try {
      final response = await _authService.resetPassword(
        userId: userId,
        otp: otp,
        token: 'null',
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response is ApiError) {
        emit(ResetPasswordError(response.message));
        return;
      }

      if (response is Map<String, dynamic> && response["succeeded"] == true) {
        emit(ResetPasswordSuccess(email: email, password: newPassword));
      } else if (response is Map<String, dynamic>) {
        emit(ResetPasswordError(response["message"] ?? "Reset failed"));
      } else {
        emit(ResetPasswordError("Unexpected error"));
      }
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }
}
