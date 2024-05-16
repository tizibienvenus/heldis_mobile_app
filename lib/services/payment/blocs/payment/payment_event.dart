part of 'payment_bloc.dart';

sealed class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class BuyPlanEvent extends PaymentEvent {
  final int planId;
  final String phone;
  final double amount;
  const BuyPlanEvent(
      {required this.planId, required this.phone, required this.amount});
}
