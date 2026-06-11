import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rewarding_kids/features/auth/cubit/forget_password_state.dart';
import 'package:rewarding_kids/features/auth/data/services/auth_service.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthService _authService = AuthService();

  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> forgotPassword(String email) async {
    emit(ForgetPasswordLoading());

    final response = await _authService.forgotPassword(email: email);

    if (response["succeeded"] == true) {
      final userId = response["data"]["userId"];

      emit(ForgetPasswordSuccess(userId));
    } else {
      emit(ForgetPasswordError(response["message"] ?? "Something went wrong"));
    }
  }
}
