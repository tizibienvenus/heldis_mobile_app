part of 'connexion_bloc.dart';

sealed class ConnexionEvent extends Equatable {
  const ConnexionEvent();

  @override
  List<Object> get props => [];
}

class ConnexionLoadEvent extends ConnexionEvent {
  final UserEntity? user;
  final String? token;
  final String id;

  const ConnexionLoadEvent({this.user, this.token, this.id = ''});

  @override
  List<Object> get props => [
        id,
      ];
}
