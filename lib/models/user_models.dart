// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// enum UserRole {father, mother, other}

// @immutable
// class User extends Equatable {
//   final String uid;
//   final String email;
//   final String name;
//   final String phone;
//   final String profileImageUrl;
//   final int subscribeId;
//   final UserRole userRole;
//   final int createdAt;
//   final int updatedAt;

//   const User({
//     required this.uid,
//     required this.email,
//     required this.name,
//     required this.phone,
//     required this.profileImageUrl,
//     required this.subscribeId,
//     required this.userRole,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   @override
//   List<Object> get props {
//     return [
//       uid,
//       email,
//       name,
//       phone,
//       profileImageUrl,
//       userRole,
//       subscribeId,
//       createdAt,
//       updatedAt,
//     ];
//   }

//   User copyWith({
//     String? uid,
//     String? email,
//     String? name,
//     String? phone,
//     String? profileImageUrl,
//     UserRole? userRole,
//     int? createdAt,
//     int? updatedAt,
//     bool? isActive,
//     int? dob,
//     List<String>? favorites,
//   }) {
//     return User(
//       uid: uid ?? this.uid,
//       email: email ?? this.email,
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       userRole: userRole ?? this.userRole,
//       profileImageUrl: profileImageUrl ?? this.profileImageUrl,
//       subscribeId: subscribeId ?? this.subscribeId,
//       createdAt: createdAt ?? this.createdAt,
//       updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'email': email,
//       'name': name,
//       'phone': phone,
//       'profileImageUrl': profileImageUrl,
//       'subscribeId': subscribeId,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       uid: map['uid'] ?? '',
//       email: map['email'] ?? '',
//       name: map['name'] ?? '',
//       phone: map['phone'] ?? '',
//       profileImageUrl: map['profileImageUrl'] ?? '',
//       subscribeId: map['subscribeId'] ?? '',
//       userRole: map['userRole'] ?? '',
//       createdAt: map['createdAt'] ?? 0,
//       updatedAt: map['updatedAt'] ?? 0, 
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'User(uid: $uid, email: $email, name: $name, phone: $phone, profileImageUrl: $profileImageUrl, subscribeId: $subscribeId,userRole: $userRole?? '', createdAt: $createdAt, updatedAt: $updatedAt,)';
//   }
// }