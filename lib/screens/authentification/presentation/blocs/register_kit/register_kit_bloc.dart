import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/authentification/domain/usecase/auth_usecase.dart';

part 'register_kit_event.dart';
part 'register_kit_state.dart';

class RegisterKitBloc extends Bloc<RegisterKitEvent, RegisterKitState> {
  final AuthUsecase authUsecase;
  RegisterKitBloc({required this.authUsecase}) : super(RegisterKitInitial()) {
    on<RegisterKitEvent>((event, emit) {});

    on<RegisterKitSubmitEvent>((event, emit) async {
      emit(RegisterKitLoading());

      final result = await authUsecase.registerKit(
        name: event.name,
        avatar: event.avatar,
        description: event.description,
        birthDate: event.birthDate,
        gpsSimNumber: event.gpsSimNumber,
      );

      result.fold((l) {
        emit(RegisterKitError(message: l.message));
      }, (r) {
        emit(RegisterKitSuccess());
      });
    });
  }
}
