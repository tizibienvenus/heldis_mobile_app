part of 'handle_child_bloc.dart';

sealed class HandleChildState extends Equatable {
  const HandleChildState();

  @override
  List<Object> get props => [];
}

final class HandleChildInitial extends HandleChildState {}

final class UpdateChildInfoLoading extends HandleChildState {}

final class UpdateChildInfoSuccess extends HandleChildState {}

final class UpdateChildInfoError extends HandleChildState {
  final String message;

  const UpdateChildInfoError({required this.message});
}
