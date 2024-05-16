import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/services/payment/data/model/pay_subscription_response_model.dart';
import 'package:heldis/services/payment/domain/payment_usecase.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentUsecase paymentUsecase;

  PaymentBloc({required this.paymentUsecase}) : super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {});

    on<BuyPlanEvent>(buyPlan);
  }

  FutureOr<void> buyPlan(event, emit) async {
    emit(BuyPlanLoading());

    var result = await paymentUsecase.buyPlan(
      planId: event.planId,
      phone: event.phone,
      amount: event.amount,
    );

    result.fold((failure) {
      emit(BuyPlanError(message: failure.message));
    }, (res) {
      emit(BuyPlanSuccess(paySubscriptionResponseModel: res));
    });
  }
}
