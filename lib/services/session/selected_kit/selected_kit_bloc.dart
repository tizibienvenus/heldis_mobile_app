import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_kit_event.dart';
part 'selected_kit_state.dart';

class SelectedKitBloc extends Bloc<SelectedKitEvent, SelectedKitState> {
  SelectedKitBloc() : super(SelectedKitInitial()) {
    on<SelectedKitEvent>((event, emit) {});

    on<ChangeSelectedKitEvent>((event, emit) {
      emit(ChangeKitIdState(kitId: event.kit));
    });
  }
}
