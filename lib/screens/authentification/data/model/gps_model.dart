import 'package:heldis/screens/authentification/domain/entities/gps_entity.dart';

class GpsModel {
  int? id;
  String? chargeLevel;
  String? simNumber;
  int? childId;
  String? createdAt;
  String? updatedAt;

  GpsModel(
      {this.id,
      this.chargeLevel,
      this.simNumber,
      this.childId,
      this.createdAt,
      this.updatedAt});

  GpsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chargeLevel = json['charge_level'];
    simNumber = json['sim_number'];
    childId = json['child_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['charge_level'] = this.chargeLevel;
    data['sim_number'] = this.simNumber;
    data['child_id'] = this.childId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  GpsEntity toEntity() {
    return GpsEntity(
      id: id,
      chargeLevel: chargeLevel,
      simNumber: simNumber,
      childId: childId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
