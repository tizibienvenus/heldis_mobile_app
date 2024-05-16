import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/kit/controller/kit_usecase.dart';

part 'zone_handle_event.dart';
part 'zone_handle_state.dart';

class ZoneHandleBloc extends Bloc<ZoneHandleEvent, ZoneHandleState> {
  final KitUseCase _kitUseCase;
  ZoneHandleBloc({required KitUseCase kitUseCase})
      : _kitUseCase = kitUseCase,
        super(ZoneHandleInitial()) {
    on<ZoneHandleEvent>((event, emit) {});

    on<AddZoneEvent>((event, emit) async {
      emit(AddZoneLoading());

      var result = await _kitUseCase.addZone(
          zoneName: event.zoneName,
          radius: event.radius,
          lat: event.lat,
          lng: event.lng,
          childId: event.childId);

      result.fold((failure) {
        emit(AddZoneError(message: failure.message));
      }, (res) {
        emit(AddZoneSuccess());
      });
    });

    on<DeleteZoneEvent>((event, emit) async {
      emit(DeleteZoneLoading());

      var result = await _kitUseCase.deleteZone(
          zoneId: event.zoneId, childId: event.childId);

      result.fold((failure) {
        emit(DeleteZoneError(message: failure.message));
      }, (res) {
        emit(DeleteZoneSuccess());
      });
    });
  }
}
