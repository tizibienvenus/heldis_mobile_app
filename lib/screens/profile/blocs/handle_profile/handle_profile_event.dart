part of 'handle_profile_bloc.dart';

sealed class HandleProfileEvent extends Equatable {
  const HandleProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends HandleProfileEvent {
  final String name;
  final String phone;
  final String email;
  final String avatar;

  const UpdateProfileEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.avatar,
  });
}

class UpdatePasswordEvent extends HandleProfileEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const UpdatePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}

class DeleteProfileEvent extends HandleProfileEvent {}
