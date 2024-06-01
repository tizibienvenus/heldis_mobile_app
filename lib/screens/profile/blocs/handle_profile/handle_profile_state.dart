part of 'handle_profile_bloc.dart';

sealed class HandleProfileState extends Equatable {
  const HandleProfileState();

  @override
  List<Object> get props => [];
}

final class HandleProfileInitial extends HandleProfileState {}

final class UpdateProfileLoading extends HandleProfileState {}

final class UpdateProfileSuccess extends HandleProfileState {}

final class UpdateProfileError extends HandleProfileState {
  final String message;

  const UpdateProfileError(this.message);
}

final class DeleteProfileLoading extends HandleProfileState {}

final class DeleteProfileSuccess extends HandleProfileState {}

final class DeleteProfileError extends HandleProfileState {
  final String message;

  const DeleteProfileError(this.message);
}

final class UpdatePasswordLoading extends HandleProfileState {}

final class UpdatePasswordSuccess extends HandleProfileState {}

final class UpdatePasswordError extends HandleProfileState {
  final String message;

  const UpdatePasswordError(this.message);
}
