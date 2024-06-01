// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PlanResponseModel {
  List<PlanModel>? plans;

  PlanResponseModel({this.plans});

  PlanResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      plans = <PlanModel>[];
      json['data'].forEach((v) {
        plans!.add(PlanModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (plans != null) {
      data['data'] = plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// ignore: must_be_immutable
class PlanModel extends Equatable {
  int? id;
  String? name;
  int? price;
  String? description;
  int? additionalMonth;
  String? createdAt;
  String? updatedAt;

  PlanModel(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.additionalMonth,
      this.createdAt,
      this.updatedAt});

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    additionalMonth = json['additional_month'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['additional_month'] = additionalMonth;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      price,
      description,
      additionalMonth,
      createdAt,
      updatedAt,
    ];
  }
}
