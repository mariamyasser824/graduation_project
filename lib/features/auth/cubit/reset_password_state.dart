import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/network/api_error.dart';
import 'package:rewarding_kids/features/auth/cubit/forget_password_state.dart';
import 'package:rewarding_kids/features/auth/data/services/auth_service.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

// في reset_password_state.dart
class ResetPasswordSuccess extends ResetPasswordState {
  final String email; // 👈 ضيف دول
  final String password; // 👈
  ResetPasswordSuccess({required this.email, required this.password});
}

class ResetPasswordError extends ResetPasswordState {
  final String error;
  ResetPasswordError(this.error);
}
