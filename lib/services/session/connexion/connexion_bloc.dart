import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

part 'connexion_event.dart';
part 'connexion_state.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  ConnexionBloc() : super(ConnexionInitial()) {
    on<ConnexionEvent>((event, emit) {});

    on<ConnexionLoadEvent>(connexionState);
  }

  FutureOr<void> connexionState(event, emit) async {
    emit(ConnexionLoad(event.user, event.token, Uuid().v4()));
  }
}
