part of 'get_children_bloc.dart';

sealed class GetChildrenState extends Equatable {
  const GetChildrenState();

  @override
  List<Object> get props => [];
}

final class GetChildrenInitial extends GetChildrenState {}

final class GetChildrenLoading extends GetChildrenState {}

final class GetChildrenSuccess extends GetChildrenState {
  final List<ChildModel> children;

  const GetChildrenSuccess({required this.children});
}

final class GetChildrenError extends GetChildrenState {
  final String message;

  const GetChildrenError({required this.message});
}
