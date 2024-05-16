// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:heldis/screens/kit/model/child_zone_model.dart';

class GetAllChildResponseModel extends Equatable {
  List<ChildModel>? data;

  GetAllChildResponseModel({this.data});

  GetAllChildResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChildModel>[];
      json['data'].forEach((v) {
        data!.add(ChildModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [...data?.map((e) => e).toList() ?? []];
}

class ChildModel extends Equatable {
  int? id;
  String? name;
  String? description;
  String? birthDate;
  String? avatar;
  String? school;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<ChildZone>? zones;
  ChildGps? gps;

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
      zones = <ChildZone>[];
      json['zones'].forEach((v) {
        zones!.add(ChildZone.fromJson(v));
      });
    }
    gps = json['gps'] != null ? ChildGps.fromJson(json['gps']) : null;
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

  @override
  List<Object?> get props {
    return [
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
      gps,
    ];
  }
}

class ChildGps extends Equatable {
  int? id;
  String? chargeLevel;
  String? simNumber;
  int? childId;
  String? createdAt;
  String? updatedAt;

  ChildGps(
      {this.id,
      this.chargeLevel,
      this.simNumber,
      this.childId,
      this.createdAt,
      this.updatedAt});

  ChildGps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chargeLevel = json['charge_level'];
    simNumber = json['sim_number'];
    childId = json['child_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['charge_level'] = chargeLevel;
    data['sim_number'] = simNumber;
    data['child_id'] = childId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  List<Object?> get props {
    return [
      id,
      chargeLevel,
      simNumber,
      childId,
      createdAt,
      updatedAt,
    ];
  }
}
