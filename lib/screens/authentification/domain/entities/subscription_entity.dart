import 'package:equatable/equatable.dart';

class SubscriptionEntity extends Equatable {
  final int? id;
  final String? startAt;
  final String? endsAt;
  final String? status;
  final int? planId;
  final int? userId;
  final String? paymentRef;
  final String? createdAt;
  final String? updatedAt;

  const SubscriptionEntity(
      {this.id,
      this.startAt,
      this.endsAt,
      this.planId,
      this.userId,
      this.paymentRef,
      this.status,
      this.createdAt,
      this.updatedAt});

  @override
  List<Object?> get props => [
        id,
        startAt,
        endsAt,
        planId,
        userId,
        paymentRef,
        status,
        createdAt,
        updatedAt,
      ];

  factory SubscriptionEntity.fromJson(Map<String, dynamic> json) =>
      SubscriptionEntity(
        id: json['id'],
        startAt: json['start_at'],
        endsAt: json['ends_at'],
        planId: json['plan_id'],
        status: json['status'],
        userId: json['user_id'],
        paymentRef: json['payment_ref'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'start_at': startAt,
        'ends_at': endsAt,
        'plan_id': planId,
        'user_id': userId,
        'status': status,
        'payment_ref': paymentRef,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
