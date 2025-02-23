part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginButtonPressed extends AuthEvent {}

class LogoutButtonPressed extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class UpdateUser extends AuthEvent {
  final UserModel user;

  UpdateUser({required this.user});
}
