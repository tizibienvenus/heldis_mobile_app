import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ChildZone extends Equatable {
  int? id;
  String? zoneName;
  String? zoneDescription;
  int? radius;
  double? lat;
  double? lng;
  int? childId;
  String? createdAt;
  String? updatedAt;

  ChildZone(
      {this.id,
      this.zoneName,
      this.zoneDescription,
      this.radius,
      this.lat,
      this.lng,
      this.childId,
      this.createdAt,
      this.updatedAt});

  ChildZone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneName = json['zone_name'];
    zoneDescription = json['zone_description'];
    radius = json['radius'];
    lat = json['lat'];
    lng = json['lng'];
    childId = json['child_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['zone_name'] = zoneName;
    data['zone_description'] = zoneDescription;
    data['radius'] = radius;
    data['lat'] = lat;
    data['lng'] = lng;
    data['child_id'] = childId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  List<Object?> get props {
    return [
      id,
      zoneName,
      zoneDescription,
      radius,
      lat,
      lng,
      childId,
      createdAt,
      updatedAt,
    ];
  }
}
