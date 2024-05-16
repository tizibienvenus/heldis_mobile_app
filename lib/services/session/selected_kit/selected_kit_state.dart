part of 'selected_kit_bloc.dart';

sealed class SelectedKitState extends Equatable {
  const SelectedKitState({
    required this.kitId,
  });

  final int kitId;

  @override
  List<Object> get props => [kitId];
}

final class SelectedKitInitial extends SelectedKitState {
  const SelectedKitInitial() : super(kitId: 0);
}

final class ChangeKitIdState extends SelectedKitState {
  const ChangeKitIdState({required super.kitId});
}
