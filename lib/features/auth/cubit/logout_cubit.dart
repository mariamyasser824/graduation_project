import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/pref_helper.dart';
import '../data/services/auth_service.dart';
import 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthService _authService = AuthService();

  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      final response = await _authService.logout();

      // لو السيرفر رجع OK
      if (response != null && response["statusCode"] == "OK") {
        await PrefHelper.clearTokens(); // ننظف كل التوكنات
        emit(LogoutSuccess(message: response["message"] ?? "Logged out successfully"));
      } else {
        emit(LogoutError(response["message"] ?? "Logout failed"));
      }
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}
