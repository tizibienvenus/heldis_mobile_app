part of 'get_plans_bloc.dart';

sealed class GetPlansState extends Equatable {
  const GetPlansState();

  @override
  List<Object> get props => [];
}

final class GetPlansInitial extends GetPlansState {}

final class GetPlansLoading extends GetPlansState {}

final class GetPlansSuccess extends GetPlansState {
  final List<PlanModel> plans;

  const GetPlansSuccess(this.plans);

  @override
  List<Object> get props => [plans];
}

final class GetPlansError extends GetPlansState {
  final String message;

  const GetPlansError(this.message);

  @override
  List<Object> get props => [message];
}
