import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/kit/controller/kit_usecase.dart';

part 'handle_child_event.dart';
part 'handle_child_state.dart';

class HandleChildBloc extends Bloc<HandleChildEvent, HandleChildState> {
  final KitUseCase kitUsecase;

  HandleChildBloc({required this.kitUsecase}) : super(HandleChildInitial()) {
    on<HandleChildEvent>((event, emit) {});

    on<UpdateChildInfoEvent>((event, emit) async {
      emit(UpdateChildInfoLoading());
      final result = await kitUsecase.updateChild(
          childId: event.childId,
          name: event.name,
          avatar: event.avatar,
          birthDate: event.birthDate,
          gpsSimNumber: event.gpsSimNumber,
          description: event.description);
      result.fold(
        (l) => emit(UpdateChildInfoError(message: l.message)),
        (r) => emit(UpdateChildInfoSuccess()),
      );
    });
  }
}
