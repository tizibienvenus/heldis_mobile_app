import 'package:heldis/screens/authentification/data/model/gps_model.dart';
import 'package:heldis/screens/authentification/data/model/zone_model.dart';
import 'package:heldis/screens/authentification/domain/entities/child_entity.dart';

class ChildModel {
  int? id;
  String? name;
  String? description;
  String? birthDate;
  String? avatar;
  String? school;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<ZoneModel>? zones;
  GpsModel? gps;

  ChildModel(
      {this.id,
      this.name,
      this.description,
      this.birthDate,
      this.avatar,
      this.school,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.zones,
      this.gps});

  ChildModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    birthDate = json['birth_date'];
    avatar = json['avatar'];
    school = json['school'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['zones'] != null) {
      zones = <ZoneModel>[];
      json['zones'].forEach((v) {
        zones!.add(ZoneModel.fromJson(v));
      });
    }
    gps = json['gps'] != null ? GpsModel.fromJson(json['gps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['birth_date'] = birthDate;
    data['avatar'] = avatar;
    data['school'] = school;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (zones != null) {
      data['zones'] = zones!.map((v) => v.toJson()).toList();
    }
    if (gps != null) {
      data['gps'] = gps!.toJson();
    }
    return data;
  }

  ChildEntity toEntity() {
    return ChildEntity(
      id: id,
      name: name,
      description: description,
      birthDate: birthDate,
      avatar: avatar,
      school: school,
      userId: userId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      zones: zones?.map((v) => v.toEntity()).toList(),
      gps: gps?.toEntity(),
    );
  }
}
