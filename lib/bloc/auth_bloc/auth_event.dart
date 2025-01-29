part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginButtonPressed extends AuthEvent {}

class LogoutButtonPressed extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

