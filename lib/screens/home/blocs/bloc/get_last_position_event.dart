part of 'get_last_position_bloc.dart';

sealed class GetLastPositionEvent extends Equatable {
  const GetLastPositionEvent();

  @override
  List<Object> get props => [];
}

class GetLastPosition extends GetLastPositionEvent {
  const GetLastPosition();
}
