import 'package:dio/dio.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childRequestModel.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childmodel.dart';

class AuthService {
  final ApiService _api = ApiService();

  /// Signup
  Future<dynamic> signup({
    required String email,
    required String password,
    required String confirmPassword,
    required String fullName,
  }) async {
    final response = await _api.post(ApiConstants.register, {
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "fullName": fullName,
    });

    return response;
  }

  /// OTP Verification
  Future<dynamic> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _api.post(ApiConstants.verifyOtp, {
      "email": email,
      "otp": otp,
    });

    return response;
  }

  Future<dynamic> resendOtp({
    required String email,
    String? userId,
    required String flow, // new
  }) async {
    final body = {
      "email": email,
      "flow": flow, // مهم
    };

    if (userId != null) {
      body["userId"] = userId;
    }

    final response = await _api.post(ApiConstants.resendOtp, body);

    return response;
  }

  Future<dynamic> login({
    required String identifier,
    required String password,
    required String loginAs,
  }) async {
    final response = await _api.post(ApiConstants.login, {
      "identifier": identifier,
      "password": password,
      "loginAs": loginAs,
    });
    return response;
  }

  Future<dynamic> refreshToken() async {
    final refreshToken = await PrefHelper.getRefreshToken();

    final response = await _api.post(ApiConstants.refreshToken, {
      "refreshToken": refreshToken,
    });

    return response;
  }

  Future<dynamic> logout() async {
    final response = await _api.post(
      ApiConstants.logout,
      {},
    ); // الـ POST لكن بدون Body
    return response;
  }

  /// Forgot Password/// Forgot Password
  Future<dynamic> forgotPassword({required String email}) async {
    final response = await _api.post(ApiConstants.forgotPassword, {
      "email": email,
    });

    return response;
  }

  /// Reset Password
  Future<dynamic> resetPassword({
    required String userId,
    required String otp,
    String? token, // nullable
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await _api.post(ApiConstants.resetPassword, {
      "userId": userId,
      "otp": otp,
      "token": token, // null عادي
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });

    return response;
  }
}
