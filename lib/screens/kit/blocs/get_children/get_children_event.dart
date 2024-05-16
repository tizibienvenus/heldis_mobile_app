part of 'get_children_bloc.dart';

sealed class GetChildrenEvent extends Equatable {
  const GetChildrenEvent();

  @override
  List<Object> get props => [];
}

class GetChildren extends GetChildrenEvent {
  const GetChildren();
}
