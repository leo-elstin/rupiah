part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class FetchingOTP extends AuthState {}

class FetchedOTP extends AuthState {}

class ValidatingOTP extends AuthState {}

class UserLoggedIn extends AuthState {}

class UserNotLoggedIn extends AuthState {}

class AuthSuccess extends AuthState {}
