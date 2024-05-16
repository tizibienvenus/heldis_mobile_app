part of 'register_kit_bloc.dart';

sealed class RegisterKitState extends Equatable {
  const RegisterKitState();

  @override
  List<Object> get props => [];
}

final class RegisterKitInitial extends RegisterKitState {}

final class RegisterKitLoading extends RegisterKitState {}

final class RegisterKitError extends RegisterKitState {
  final String message;
  const RegisterKitError({required this.message});
}

final class RegisterKitSuccess extends RegisterKitState {}
