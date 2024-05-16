part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

// Login states
final class LoginLoading extends AuthState {}

final class LoginError extends AuthState {
  final String message;
  const LoginError({required this.message});
}

final class LoginSuccess extends AuthState {
  final LoginResponseModel responseModel;
  const LoginSuccess({required this.responseModel});
}

// register states
final class RegisterLoading extends AuthState {}

final class RegisterError extends AuthState {
  final String message;
  const RegisterError({required this.message});
}

final class RegisterSuccess extends AuthState {
  final UserEntity user;
  const RegisterSuccess({required this.user});
}

// logout states
final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {
  final String message;
  const LogoutSuccess({required this.message});
}

final class LogoutError extends AuthState {
  final String message;
  const LogoutError({required this.message});
}
