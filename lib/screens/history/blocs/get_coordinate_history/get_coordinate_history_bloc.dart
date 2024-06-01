import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/history/controller/history_usecase.dart';
import 'package:heldis/screens/history/model/coordinate_model.dart';

part 'get_coordinate_history_event.dart';
part 'get_coordinate_history_state.dart';

class GetCoordinateHistoryBloc
    extends Bloc<GetCoordinateHistoryEvent, GetCoordinateHistoryState> {
  final HistoryUseCase historyUseCase;
  GetCoordinateHistoryBloc({required this.historyUseCase})
      : super(GetCoordinateHistoryInitial()) {
    on<GetCoordinateHistoryEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetCoordinateHistory>((event, emit) async {
      emit(GetCoordinateHistoryLoading());

      var result = await historyUseCase.getCoordinateHistory(
        dateStart: event.dateStart,
        dateEnd: event.dateEnd,
      );

      result.fold((failure) {
        emit(GetCoordinateHistoryFailure(message: failure.message));
      }, (data) {
        emit(GetCoordinateHistorySuccess(coordinates: data));
      });
    });
  }
}
