part of 'zone_handle_bloc.dart';

sealed class ZoneHandleState extends Equatable {
  const ZoneHandleState();

  @override
  List<Object> get props => [];
}

final class ZoneHandleInitial extends ZoneHandleState {}

final class AddZoneLoading extends ZoneHandleState {}

final class AddZoneSuccess extends ZoneHandleState {}

final class AddZoneError extends ZoneHandleState {
  final String message;

  const AddZoneError({required this.message});
}

final class DeleteZoneLoading extends ZoneHandleState {}

final class DeleteZoneSuccess extends ZoneHandleState {}

final class DeleteZoneError extends ZoneHandleState {
  final String message;

  const DeleteZoneError({required this.message});
}
