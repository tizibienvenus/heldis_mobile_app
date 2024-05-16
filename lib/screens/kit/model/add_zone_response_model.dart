import 'package:heldis/screens/kit/model/child_zone_model.dart';

class AddZoneResponseModel {
  ChildZone? data;

  AddZoneResponseModel({this.data});

  AddZoneResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ChildZone.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
