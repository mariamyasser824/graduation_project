import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/auth/data/services/auth_service.dart';
import 'signup_state.dart';
import '../../../core/network/api_error.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthService _authService = AuthService();

  SignupCubit() : super(SignupInitial());

  Future<void> signup({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
  }) async {
    emit(SignupLoading());

    final response = await _authService.signup(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      fullName: fullName,
    );

    if (response is ApiError) {
      emit(SignupError(response.message));
    } else {
      emit(
        SignupSuccess(
          message: response["message"] ?? "Account created successfully",
          email: email,
        ),
      );
    }
  }
}
