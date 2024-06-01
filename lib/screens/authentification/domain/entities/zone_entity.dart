import 'package:equatable/equatable.dart';

class ZoneEntity extends Equatable {
  final int? id;
  final String? zoneName;
  final String? zoneDescription;
  final int? radius;
  final double? lat;
  final double? lng;
  final int? childId;
  final String? createdAt;
  final String? updatedAt;

  const ZoneEntity({
    this.id,
    this.zoneName,
    this.zoneDescription,
    this.radius,
    this.lat,
    this.lng,
    this.childId,
    this.createdAt,
    this.updatedAt,
  });

  factory ZoneEntity.fromJson(Map<String, dynamic> json) => ZoneEntity(
        id: json['id'],
        zoneName: json['zone_name'],
        zoneDescription: json['zone_description'],
        radius: json['radius'],
        lat: json['lat'],
        lng: json['lng'],
        childId: json['child_id'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'zone_name': zoneName,
        'zone_description': zoneDescription,
        'radius': radius,
        'lat': lat,
        'lng': lng,
        'child_id': childId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  List<Object?> get props => [
        id,
        zoneName,
        zoneDescription,
        radius,
        lat,
        lng,
        childId,
        createdAt,
        updatedAt
      ];
}
