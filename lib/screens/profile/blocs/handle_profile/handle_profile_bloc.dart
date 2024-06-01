import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/profile/controller/profile_usecase.dart';

part 'handle_profile_event.dart';
part 'handle_profile_state.dart';

class HandleProfileBloc extends Bloc<HandleProfileEvent, HandleProfileState> {
  final ProfileUseCase profileUseCase;
  HandleProfileBloc({required this.profileUseCase})
      : super(HandleProfileInitial()) {
    on<HandleProfileEvent>((event, emit) {});

    on<DeleteProfileEvent>((event, emit) async {
      emit(DeleteProfileLoading());
      var result = await profileUseCase.delete();
      result.fold(
        (l) => emit(DeleteProfileError(l.message)),
        (r) => emit(DeleteProfileSuccess()),
      );
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(UpdateProfileLoading());
      var result = await profileUseCase.update(
        name: event.name,
        email: event.email,
        avatar: event.avatar,
        phone: event.phone,
      );
      result.fold(
        (l) => emit(UpdateProfileError(l.message)),
        (r) => emit(UpdateProfileSuccess()),
      );
    });

    on<UpdatePasswordEvent>((event, emit) async {
      emit(UpdatePasswordLoading());
      var result = await profileUseCase.updatePassword(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      );
      result.fold(
        (l) => emit(UpdatePasswordError(l.message)),
        (r) => emit(UpdatePasswordSuccess()),
      );
    });
  }
}
