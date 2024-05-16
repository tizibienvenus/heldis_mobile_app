import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/domain/usecase/auth_usecase.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  AuthUsecase authUsecase;
  GetUserBloc({required this.authUsecase}) : super(GetUserInitial()) {
    on<GetUserEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetUser>((event, emit) async {
      emit(GetUserLoading());

      final result = await authUsecase.getUserInfo();
      result.fold((l) {
        emit(GetUserError(message: l.message));
      }, (user) {
        emit(GetUserSuccess(user: user));
      });
    });
  }
}
