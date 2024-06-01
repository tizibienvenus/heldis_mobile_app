part of 'handle_child_bloc.dart';

sealed class HandleChildEvent extends Equatable {
  const HandleChildEvent();

  @override
  List<Object> get props => [];
}

class UpdateChildInfoEvent extends HandleChildEvent {
  final int childId;
  final String name;
  final String avatar;
  final String birthDate;
  final String gpsSimNumber;
  final String description;

  const UpdateChildInfoEvent({
    required this.childId,
    required this.name,
    required this.avatar,
    required this.birthDate,
    required this.gpsSimNumber,
    required this.description,
  });
}
