// lib/bloc/auth_state.dart
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String bearerToken;

  AuthAuthenticated(this.bearerToken);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
