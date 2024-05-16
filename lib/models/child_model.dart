// import 'dart:convert';

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// @immutable
// class ChildModel extends Equatable {
//   final String cid;
//   final String scholl;
//   final String name;
//   final String birthYear;
//   final String childImage;

//   const ChildModel({
//     required this.cid,
//     required this.scholl,
//     required this.name,
//     required this.birthYear,
//     required this.childImage,
//   });

//   @override
//   List<Object> get props {
//     return [
//       cid,
//       scholl,
//       name,
//       birthYear,
//       childImage,
//     ];
//   }

//   ChildModel copyWith({
//     String? cid,
//     String? scholl,
//     String? name,
//     String? birthYear,
//     String? childImage,
//     int? createdAt,
//     int? updatedAt,
//     bool? isActive,
//     int? dob,
//     List<String>? favorites,
//   }) {
//     return ChildModel(
//       cid: cid ?? this.cid,
//       scholl: scholl ?? this.scholl,
//       name: name ?? this.name,
//       birthYear: birthYear ?? this.birthYear,
//       childImage: childImage ?? this.childImage,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'cid': cid,
//       'scholl': scholl,
//       'name': name,
//       'birthYear': birthYear,
//       'childImage': childImage,
//     };
//   }

//   factory ChildModel.fromMap(Map<String, dynamic> map) {
//     return ChildModel(
//       cid: map['cid'] ?? '',
//       scholl: map['scholl'] ?? '',
//       name: map['name'] ?? '',
//       birthYear: map['birthYear'] ?? '',
//       childImage: map['childImage'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ChildModel.fromJson(String source) =>
//       ChildModel.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'ChildModel(cid: $cid, scholl: $scholl, name: $name, birthYear: $birthYear, childImage: $childImage,)';
//   }
// }
