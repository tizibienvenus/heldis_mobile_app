import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heldis/services/payment/data/model/plan_response_model.dart';
import 'package:heldis/services/payment/domain/payment_usecase.dart';

part 'get_plans_event.dart';
part 'get_plans_state.dart';

class GetPlansBloc extends Bloc<GetPlansEvent, GetPlansState> {
  final PaymentUsecase paymentUsecase;
  GetPlansBloc({required this.paymentUsecase}) : super(GetPlansInitial()) {
    on<GetPlansEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetPlans>((event, emit) async {
      emit(GetPlansLoading());

      var res = await paymentUsecase.getPaymentPlans();

      res.fold((l) => emit(GetPlansError(l.message)),
          (r) => emit(GetPlansSuccess(r.plans!)));
    });
  }
}
