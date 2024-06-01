import 'package:dartz/dartz.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/errors/failures.dart';
import 'package:heldis/services/payment/data/model/pay_subscription_response_model.dart';
import 'package:heldis/services/payment/data/model/plan_response_model.dart';
import 'package:heldis/services/payment/data/payment_remote_datasource.dart';
import 'package:heldis/type/type_def.dart';

class PaymentUsecase {
  final PaymentRemoteDataSource paymentRemoteDataSource;

  PaymentUsecase({required this.paymentRemoteDataSource});

  ResultFuture<PlanResponseModel> getPaymentPlans() async {
    try {
      var res = await paymentRemoteDataSource.getPaymentPlans();
      return Right(res);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<PaySubscriptionResponseModel> buyPlan({
    required int planId,
    required String phone,
    required double amount,
  }) async {
    try {
      var res = await paymentRemoteDataSource.buyPlan(
        planId: planId,
        phone: phone,
        amount: amount,
      );
      return Right(res);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
