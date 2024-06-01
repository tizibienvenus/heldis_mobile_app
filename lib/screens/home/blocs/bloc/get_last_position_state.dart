part of 'get_last_position_bloc.dart';

sealed class GetLastPositionState extends Equatable {
  const GetLastPositionState();

  @override
  List<Object> get props => [];
}

final class GetLastPositionInitial extends GetLastPositionState {}

final class GetLastPositionLoading extends GetLastPositionState {}

final class GetLastPositionSuccess extends GetLastPositionState {
  final CoordinateModel coordinate;

  const GetLastPositionSuccess(this.coordinate);

  @override
  List<Object> get props => [coordinate];
}

final class GetLastPositionError extends GetLastPositionState {
  final String message;

  const GetLastPositionError(this.message);

  @override
  List<Object> get props => [message];
}
