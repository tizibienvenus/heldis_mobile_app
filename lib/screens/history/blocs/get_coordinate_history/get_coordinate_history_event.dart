part of 'get_coordinate_history_bloc.dart';

sealed class GetCoordinateHistoryEvent extends Equatable {
  const GetCoordinateHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetCoordinateHistory extends GetCoordinateHistoryEvent {
  final String dateStart;
  final String dateEnd;
  const GetCoordinateHistory({
    required this.dateStart,
    required this.dateEnd,
  });
}
