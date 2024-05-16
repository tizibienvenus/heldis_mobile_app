import 'package:equatable/equatable.dart';
import 'package:heldis/screens/authentification/domain/entities/child_entity.dart';
import 'package:heldis/screens/authentification/domain/entities/subscription_entity.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final int? isAdmin;
  final String? phone;
  final String? email;
  final String? avatar;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final List<SubscriptionEntity>? subscriptions;
  final List<ChildEntity>? children;

  const UserEntity(
      {this.id,
      this.name,
      this.isAdmin,
      this.phone,
      this.email,
      this.avatar,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.subscriptions,
      this.children});

  @override
  List<Object?> get props => [
        id,
        name,
        isAdmin,
        phone,
        email,
        avatar,
        emailVerifiedAt,
        createdAt,
        updatedAt,
        subscriptions,
        children
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isAdmin': isAdmin,
      'phone': phone,
      'email': email,
      'avatar': avatar,
      'emailVerifiedAt': emailVerifiedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'subscriptions': subscriptions?.map((v) => v.toJson()).toList(),
      'children': children?.map((v) => v.toJson()).toList(),
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      isAdmin: json['isAdmin'],
      phone: json['phone'],
      email: json['email'],
      avatar: json['avatar'],
      emailVerifiedAt: json['emailVerifiedAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      subscriptions: (json['subscriptions'] as List<dynamic>?)
          ?.map((v) => SubscriptionEntity.fromJson(v))
          .toList(),
      children: (json['children'] as List<dynamic>?)
          ?.map((v) => ChildEntity.fromJson(v))
          .toList(),
    );
  }

  SubscriptionStatus get subscriptionIsActive {
    if (subscriptions == null || subscriptions!.isEmpty) {
      return SubscriptionStatus.inactive;
    }
    final lastSubscription = subscriptions!.last;

    if (lastSubscription.status == 'pending') {
      return SubscriptionStatus.pending;
    }

    if (lastSubscription.status == 'failed') {
      return SubscriptionStatus.failed;
    }

    if (lastSubscription.status == 'active') {
      final endDate = DateTime.parse(lastSubscription.endsAt!);

      if (DateTime.now().isAfter(endDate)) {
        return SubscriptionStatus.expired;
      }
      return SubscriptionStatus.active;
    }

    return SubscriptionStatus.inactive;
  }
}

enum SubscriptionStatus {
  active,
  expired,
  inactive,
  failed,
  pending,
}
