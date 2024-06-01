import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/history/controller/history_usecase.dart';
import 'package:heldis/screens/history/model/coordinate_model.dart';

part 'get_last_position_event.dart';
part 'get_last_position_state.dart';

class GetLastPositionBloc
    extends Bloc<GetLastPositionEvent, GetLastPositionState> {
  HistoryUseCase historyUseCase;
  GetLastPositionBloc({required this.historyUseCase})
      : super(GetLastPositionInitial()) {
    on<GetLastPositionEvent>((event, emit) {});

    on<GetLastPosition>((event, emit) async {
      emit(GetLastPositionLoading());
      var result = await historyUseCase.getLastPosition();
      result.fold((failure) {
        emit(GetLastPositionError(failure.message));
      }, (res) {
        emit(GetLastPositionSuccess(res));
      });
    });
  }
}
