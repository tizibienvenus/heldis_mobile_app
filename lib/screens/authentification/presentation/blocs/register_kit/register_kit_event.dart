part of 'register_kit_bloc.dart';

sealed class RegisterKitEvent extends Equatable {
  const RegisterKitEvent();

  @override
  List<Object> get props => [];
}

class RegisterKitSubmitEvent extends RegisterKitEvent {
  final String name;
  final String avatar;
  final String birthDate;
  final String gpsSimNumber;
  final String description;

  const RegisterKitSubmitEvent({
    required this.name,
    required this.avatar,
    required this.birthDate,
    required this.gpsSimNumber,
    required this.description,
  });
}
