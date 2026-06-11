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
    final response = await _authService.verifyOtp(email: email, otp: otp);
    if (response is ApiError) {
      emit(OtpError(response.message));
      return;
    }

    final data = Map<String, dynamic>.from(response);

    debugPrint('🟢 SUCCEEDED => ${data["succeeded"]}');

    if (response["succeeded"] == true) {
      debugPrint("🔥 SUCCESS BEFORE EMIT");
      emit(OtpSuccess(message: response["message"]));
      debugPrint("🔥 SUCCESS AFTER EMIT");
    } else {
      emit(OtpError(data["message"] ?? "OTP verification failed"));
    }
  }

  Future<void> resendOtp({
    required String email,
    String? userId,
    required String flow,
  }) async {
    if (flow == "reset") {
      await _authService.forgotPassword(email: email);
    } else {
      await _authService.resendOtp(email: email, flow: flow);
    }
  }
}
