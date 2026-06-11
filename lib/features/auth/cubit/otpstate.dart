abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {
  final String message;
  // <-- هنا ضفنا التوكن
  OtpSuccess({required this.message});
}

class OtpError extends OtpState {
  final String error;
  OtpError(this.error);
}

//enum OtpFlow { register, resetPassword }
