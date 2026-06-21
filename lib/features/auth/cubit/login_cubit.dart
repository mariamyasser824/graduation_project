// login_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_error.dart';
import '../../../core/utils/pref_helper.dart';
import '../data/services/auth_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService = AuthService();

  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String identifier,
    required String password,
    String loginAs = "Parent",
  }) async {
    emit(LoginLoading());
    try {
      final response = await _authService.login(
        identifier: identifier,
        password: password,
        loginAs: loginAs,
      );

      debugPrint('🟡 RAW RESPONSE => $response');

      if (response is ApiError) {
        emit(LoginError(response.message));
        return;
      }

      if (response is Map<String, dynamic>) {
        if (response["succeeded"] == true) {
          final data = response["data"];
          final accessToken = data["accessToken"];
          final refreshToken = data["refreshToken"];

          if (accessToken != null && accessToken.toString().isNotEmpty) {
            await PrefHelper.saveAccessToken(accessToken);
          }
          if (refreshToken != null && refreshToken.toString().isNotEmpty) {
            await PrefHelper.saveRefreshToken(refreshToken);
          }
          await PrefHelper.saveUserType(data["userType"]);
          await PrefHelper.saveUserId(data["userId"]);
          await PrefHelper.saveChildId(data["childId"]);

          emit(
            LoginSuccess(
              message: response["message"] ?? "Login successful",
              token: accessToken ?? "",
            ),
          );
        } else {
          emit(LoginError(response["message"] ?? "Login failed"));
        }
      } else {
        emit(LoginError("Invalid response format"));
      }
    } catch (e) {
      debugPrint('❌ LOGIN EXCEPTION => $e');
      emit(LoginError(e.toString()));
    }
  }
}
