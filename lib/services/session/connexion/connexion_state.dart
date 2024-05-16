part of 'connexion_bloc.dart';

sealed class ConnexionState extends Equatable {
  const ConnexionState({
    required this.user,
    required this.token,
  });

  final UserEntity? user;
  final String? token;

  @override
  List<Object?> get props => [
        user?.id,
        user?.name,
        user?.updatedAt,
        ...user?.subscriptions?.map((e) => e.endsAt) ?? [],
        token,
      ];
}

final class ConnexionInitial extends ConnexionState {
  const ConnexionInitial()
      : super(
          user: null,
          token: null,
        );
}

final class ConnexionLoad extends ConnexionState {
  const ConnexionLoad(
    UserEntity? user,
    String? token,
  ) : super(
          user: user,
          token: token,
        );

  @override
  List<Object?> get props => [
        user?.id,
        user?.name,
        user?.updatedAt,
        token,
      ];
}

final class ConnexionLoading extends ConnexionState {
  const ConnexionLoading(
    UserEntity? user,
    String? token,
  ) : super(
          user: user,
          token: token,
        );

  @override
  List<Object?> get props => [
        user?.id,
        user?.name,
        user?.updatedAt,
        token,
      ];
}
