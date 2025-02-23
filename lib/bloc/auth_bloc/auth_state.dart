part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class UserAuthenticated extends AuthState {
  final UserModel userModel;
  UserAuthenticated({required this.userModel});
}

final class UserLoading extends AuthState {}

final class UserNotAuthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

