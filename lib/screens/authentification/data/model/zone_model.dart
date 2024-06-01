import 'package:heldis/screens/authentification/domain/entities/zone_entity.dart';

class ZoneModel {
  int? id;
  String? zoneName;
  String? zoneDescription;
  int? radius;
  double? lat;
  double? lng;
  int? childId;
  String? createdAt;
  String? updatedAt;

  ZoneModel(
      {this.id,
      this.zoneName,
      this.zoneDescription,
      this.radius,
      this.lat,
      this.lng,
      this.childId,
      this.createdAt,
      this.updatedAt});

  ZoneModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zone_name'] = this.zoneName;
    data['zone_description'] = this.zoneDescription;
    data['radius'] = this.radius;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['child_id'] = this.childId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  ZoneEntity toEntity() {
    return ZoneEntity(
      id: id,
      zoneName: zoneName,
      zoneDescription: zoneDescription,
      radius: radius,
      lat: lat,
      lng: lng,
      childId: childId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
