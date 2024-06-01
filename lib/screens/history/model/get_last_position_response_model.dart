import 'package:heldis/screens/history/model/coordinate_model.dart';

class GetLastPositionResponseModel {
  CoordinateModel? data;

  GetLastPositionResponseModel({this.data});

  GetLastPositionResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CoordinateModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
