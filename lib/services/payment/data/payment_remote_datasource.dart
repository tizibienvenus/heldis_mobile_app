import 'dart:convert';

import 'package:heldis/common/function.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/services/payment/data/model/pay_subscription_response_model.dart';
import 'package:heldis/services/payment/data/model/plan_response_model.dart';
import 'package:heldis/type/type_def.dart';
import 'package:http/http.dart' as http;

abstract class PaymentRemoteDataSource {
  Future<PlanResponseModel> getPaymentPlans();
  Future<PaySubscriptionResponseModel> buyPlan({
    required int planId,
    required String phone,
    required double amount,
  });
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final http.Client client;

  PaymentRemoteDataSourceImpl({required this.client});

  @override
  Future<PlanResponseModel> getPaymentPlans() async {
    try {
      // start the request
      var response = await client.get(
        Uri.https(kBaseUrl, '$kPrefix/plan'),
        headers: headersWithToken(),
      );

      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      return PlanResponseModel.fromJson(responseJson as DataMap);
      //
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<PaySubscriptionResponseModel> buyPlan({
    required int planId,
    required String phone,
    required double amount,
  }) async {
    Map body = {
      'plan_id': planId.toString(),
      'phone': phone,
      'amount': amount.toString()
    };
    try {
      print("Buy plan 1: $planId, $phone, $amount");

      // start the request
      var response = await client.post(
        Uri.https(kBaseUrl, '$kPrefix/subscribe'),
        body: jsonEncode(body),
        headers: headersWithToken(),
      );

      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      return PaySubscriptionResponseModel.fromJson(responseJson as DataMap);
      //
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }
}
