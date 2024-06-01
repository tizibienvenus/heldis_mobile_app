// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CoordinateModel extends Equatable {
  int? id;
  String? date;
  String? longitude;
  String? latitude;
  String? gpsModuleId;

  CoordinateModel(
      {this.id, this.date, this.longitude, this.latitude, this.gpsModuleId});

  CoordinateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    gpsModuleId = json['gpsModule_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['gpsModule_id'] = gpsModuleId;
    return data;
  }

  @override
  List<Object?> get props {
    return [
      id,
      date,
      longitude,
      latitude,
      gpsModuleId,
    ];
  }
}
