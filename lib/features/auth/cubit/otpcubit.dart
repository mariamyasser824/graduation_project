import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/auth/cubit/otpstate.dart';
import 'package:rewarding_kids/features/auth/data/services/auth_service.dart';
import '../../../core/network/api_error.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthService _authService = AuthService();

  OtpCubit() : super(OtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(OtpLoading());
    try {
      final response = await _authService.verifyOtp(email: email, otp: otp);

      if (response is ApiError) {
        emit(OtpError(response.message));
        return;
      }

      if (response is Map<String, dynamic>) {
        if (response["succeeded"] == true) {
          emit(OtpSuccess(message: response["message"] ?? "Verified"));
        } else {
          emit(OtpError(response["message"] ?? "OTP verification failed"));
        }
      } else {
        emit(OtpError("Unexpected response"));
      }
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }

  Future<void> resendOtp({
    required String email,
    String? userId,
    required String flow,
  }) async {
    try {
      if (flow == "reset") {
        await _authService.forgotPassword(email: email);
      } else {
        await _authService.resendOtp(email: email, flow: flow);
      }
    } catch (e) {
      debugPrint('resend error: $e');
    }
  }
}
