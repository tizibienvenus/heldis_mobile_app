part of 'selected_kit_bloc.dart';

sealed class SelectedKitEvent extends Equatable {
  const SelectedKitEvent();

  @override
  List<Object> get props => [];
}

final class ChangeSelectedKitEvent extends SelectedKitEvent {
  final int kit;
  const ChangeSelectedKitEvent({required this.kit});

  @override
  List<Object> get props => [kit];
}
