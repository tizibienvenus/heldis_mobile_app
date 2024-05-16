part of 'payment_bloc.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class BuyPlanLoading extends PaymentState {}

final class BuyPlanSuccess extends PaymentState {
  final PaySubscriptionResponseModel paySubscriptionResponseModel;

  const BuyPlanSuccess({required this.paySubscriptionResponseModel});
}

final class BuyPlanError extends PaymentState {
  final String message;

  const BuyPlanError({required this.message});
}
