abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;
  final String email;

  SignupSuccess({required this.message, required this.email});
}

class SignupError extends SignupState {
  final String error;
  SignupError(this.error);
}
