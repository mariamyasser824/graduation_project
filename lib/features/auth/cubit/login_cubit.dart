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

    debugPrint('🔵 LOGIN REQUEST');
    debugPrint('identifier: $identifier');
    debugPrint('loginAs: $loginAs');

    final response = await _authService.login(
      identifier: identifier,
      password: password,
      loginAs: loginAs,
    );

    // طباعة الريسبونس كامل
    debugPrint('🟡 RAW RESPONSE => $response');

    // لو Error من ApiService
    if (response is ApiError) {
      debugPrint('🔴 API ERROR => ${response.message}');
      emit(LoginError(response.message));
      return;
    }

    // التأكد إن الريسبونس Map
    if (response is Map<String, dynamic>) {
      debugPrint('🟢 STATUS CODE => ${response["statusCode"]}');
      debugPrint('🟢 SUCCEEDED => ${response["succeeded"]}');
      debugPrint('🟢 MESSAGE => ${response["message"]}');
      debugPrint('🟢 DATA => ${response["data"]}');

      // ✅ الشرط الصحيح
      if (response["succeeded"] == true) {
        final data = response["data"];
        final accessToken = data["accessToken"];
        final refreshToken = data["refreshToken"];
        final userType = data["userType"];
        final userId = data["userId"];
        final childId = data["childId"];
        debugPrint('🟣 ACCESS TOKEN => $accessToken');

        if (accessToken != null && accessToken.toString().isNotEmpty) {
          await PrefHelper.saveAccessToken(accessToken);
        }

        if (refreshToken != null && refreshToken.toString().isNotEmpty) {
          await PrefHelper.saveRefreshToken(refreshToken);
        }
        await PrefHelper.saveUserType(userType);

        /// حفظ اليوزر
        await PrefHelper.saveUserId(userId);
        await PrefHelper.saveChildId(childId);
        emit(
          LoginSuccess(
            message: response["message"] ?? "Login successful",
            token: accessToken ?? "",
          ),
        );
      } else {
        debugPrint('❌ LOGIN FAILED FROM API');
        emit(LoginError(response["message"] ?? "Login failed"));
      }
    } else {
      debugPrint('❌ INVALID RESPONSE FORMAT');
      emit(LoginError("Invalid response format"));
    }
  }
}
