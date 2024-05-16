import 'package:equatable/equatable.dart';
import 'package:heldis/screens/authentification/domain/entities/gps_entity.dart';
import 'package:heldis/screens/authentification/domain/entities/zone_entity.dart';

class ChildEntity extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? birthDate;
  final String? avatar;
  final String? school;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final List<ZoneEntity>? zones;
  final GpsEntity? gps;

  const ChildEntity({
    this.id,
    this.name,
    this.description,
    this.birthDate,
    this.avatar,
    this.school,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.zones,
    this.gps,
  });

  factory ChildEntity.fromJson(Map<String, dynamic> json) {
    return ChildEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      birthDate: json['birth_date'] as String?,
      avatar: json['avatar'] as String?,
      school: json['school'] as String?,
      userId: json['user_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      zones: List<ZoneEntity>.from(
          json['zones']?.map((x) => ZoneEntity.fromJson(x))),
      gps: GpsEntity.fromJson(json['gps']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'birth_date': birthDate,
      'avatar': avatar,
      'school': school,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'zones': zones?.map((x) => x.toJson()).toList(),
      'gps': gps?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        birthDate,
        avatar,
        school,
        userId,
        createdAt,
        updatedAt,
        zones,
        gps
      ];
}
