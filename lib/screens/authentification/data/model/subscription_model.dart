import 'package:heldis/screens/authentification/domain/entities/subscription_entity.dart';

class SubscriptionModel {
  int? id;
  String? startAt;
  String? endsAt;
  int? planId;
  int? userId;
  String? paymentRef;
  String? status;
  String? createdAt;
  String? updatedAt;

  SubscriptionModel({
    this.id,
    this.startAt,
    this.endsAt,
    this.planId,
    this.userId,
    this.paymentRef,
    this.createdAt,
    this.status,
    this.updatedAt,
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAt = json['start_at'];
    endsAt = json['ends_at'];
    planId = json['plan_id'];
    userId = json['user_id'];
    status = json['status'];
    paymentRef = json['payment_ref'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_at'] = this.startAt;
    data['ends_at'] = this.endsAt;
    data['plan_id'] = this.planId;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['payment_ref'] = this.paymentRef;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  SubscriptionEntity toEntity() {
    return SubscriptionEntity(
      id: id,
      startAt: startAt,
      endsAt: endsAt,
      planId: planId,
      userId: userId,
      status: status,
      paymentRef: paymentRef,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
