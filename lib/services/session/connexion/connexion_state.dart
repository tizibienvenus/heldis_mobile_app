part of 'connexion_bloc.dart';

sealed class ConnexionState extends Equatable {
  const ConnexionState({
    required this.user,
    required this.token,
    required this.sessionId,
  });

  final UserEntity? user;
  final String? token;
  final String? sessionId;

  @override
  List<Object?> get props => [
        user?.id,
        user?.name,
        user?.updatedAt,
        ...user?.subscriptions?.map((e) => e.endsAt) ?? [],
        token,
        sessionId,
      ];
}

final class ConnexionInitial extends ConnexionState {
  const ConnexionInitial()
      : super(
          user: null,
          token: null,
          sessionId: null,
        );
}

final class ConnexionLoad extends ConnexionState {
  const ConnexionLoad(
    UserEntity? user,
    String? token,
    String? sessionId,
  ) : super(
          user: user,
          token: token,
          sessionId: sessionId,
        );
}

final class ConnexionLoading extends ConnexionState {
  const ConnexionLoading(
    UserEntity? user,
    String? token,
    String? sessionId,
  ) : super(
          user: user,
          token: token,
          sessionId: sessionId,
        );
}
