import 'package:heldis/screens/authentification/data/model/child_model.dart';
import 'package:heldis/screens/authentification/data/model/subscription_model.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';

class UserModel {
  int? id;
  String? name;
  int? isAdmin;
  String? phone;
  String? email;
  String? avatar;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  List<SubscriptionModel>? subscriptions;
  List<ChildModel>? children;

  UserModel(
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

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isAdmin = json['is_admin'];
    phone = json['phone'];
    email = json['email'];
    avatar = json['avatar'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subscriptions'] != null) {
      subscriptions = <SubscriptionModel>[];
      json['subscriptions'].forEach((v) {
        subscriptions!.add(SubscriptionModel.fromJson(v));
      });
    }
    if (json['children'] != null) {
      children = <ChildModel>[];
      json['children'].forEach((v) {
        children!.add(ChildModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['is_admin'] = isAdmin;
    data['phone'] = phone;
    data['email'] = email;
    data['avatar'] = avatar;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (subscriptions != null) {
      data['subscriptions'] = subscriptions!.map((v) => v.toJson()).toList();
    }
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      isAdmin: isAdmin,
      phone: phone,
      email: email,
      avatar: avatar,
      emailVerifiedAt: emailVerifiedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      subscriptions: subscriptions?.map((v) => v.toEntity()).toList(),
      children: children?.map((v) => v.toEntity()).toList(),
    );
  }
}
