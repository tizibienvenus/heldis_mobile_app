part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String avatar;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avatar,
  });

  @override
  List<Object> get props => [email, password, name, phone, avatar];
}

class LogoutEvent extends AuthEvent {}
