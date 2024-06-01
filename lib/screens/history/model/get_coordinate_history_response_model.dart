import 'package:heldis/screens/history/model/coordinate_model.dart';

class GetCoordinateHistoryResponseModel {
  List<CoordinateModel>? data;

  GetCoordinateHistoryResponseModel({this.data});

  GetCoordinateHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CoordinateModel>[];
      json['data'].forEach((v) {
        data!.add(CoordinateModel.fromJson(v));
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
}
