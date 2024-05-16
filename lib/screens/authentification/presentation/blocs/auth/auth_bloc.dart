import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/data/model/login_response_model.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthBloc({required this.authUsecase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      var res = await authUsecase.login(
        email: event.email,
        password: event.password,
      );

      res.fold((l) {
        emit(LoginError(message: l.errorMessage));
      }, (r) async {
        emit(LoginSuccess(responseModel: r));
      });
    });

    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      var res = await authUsecase.register(
        email: event.email,
        password: event.password,
        name: event.name,
        phone: event.phone,
        avatar: event.avatar,
      );

      res.fold((l) {
        emit(RegisterError(message: l.errorMessage));
      }, (r) async {
        emit(RegisterSuccess(user: r.data!.user!.toEntity()));
      });
    });

    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      var res = await authUsecase.logout();

      res.fold((l) {
        emit(LogoutError(message: l.errorMessage));
      }, (r) async {
        emit(const LogoutSuccess(message: 'logged out successfully'));
      });
    });
  }
}
