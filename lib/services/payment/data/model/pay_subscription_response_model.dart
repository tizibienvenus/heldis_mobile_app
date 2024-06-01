class PaySubscriptionResponseModel {
  SubscriptionModel? subscription;

  PaySubscriptionResponseModel({this.subscription});

  PaySubscriptionResponseModel.fromJson(Map<String, dynamic> json) {
    subscription =
        json['data'] != null ? SubscriptionModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subscription != null) {
      data['data'] = subscription!.toJson();
    }
    return data;
  }
}

class SubscriptionModel {
  int? userId;
  int? planId;
  String? paymentRef;
  String? updatedAt;
  String? createdAt;
  int? id;

  SubscriptionModel(
      {this.userId,
      this.planId,
      this.paymentRef,
      this.updatedAt,
      this.createdAt,
      this.id});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    planId = json['plan_id']?.toString() != null
        ? int.parse(json['plan_id'].toString())
        : null;
    paymentRef = json['payment_ref'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['plan_id'] = planId;
    data['payment_ref'] = paymentRef;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
