part of 'get_coordinate_history_bloc.dart';

sealed class GetCoordinateHistoryState extends Equatable {
  const GetCoordinateHistoryState();

  @override
  List<Object> get props => [];
}

final class GetCoordinateHistoryInitial extends GetCoordinateHistoryState {}

final class GetCoordinateHistoryLoading extends GetCoordinateHistoryState {}

final class GetCoordinateHistorySuccess extends GetCoordinateHistoryState {
  final List<CoordinateModel> coordinates;

  const GetCoordinateHistorySuccess({required this.coordinates});

  @override
  List<Object> get props => [coordinates];
}

final class GetCoordinateHistoryFailure extends GetCoordinateHistoryState {
  final String message;

  const GetCoordinateHistoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}
