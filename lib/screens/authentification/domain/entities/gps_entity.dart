import 'package:equatable/equatable.dart';

class GpsEntity extends Equatable {
  final int? id;
  final String? chargeLevel;
  final String? simNumber;
  final int? childId;
  final String? createdAt;
  final String? updatedAt;

  const GpsEntity({
    this.id,
    this.chargeLevel,
    this.simNumber,
    this.childId,
    this.createdAt,
    this.updatedAt,
  });

  factory GpsEntity.fromJson(Map<String, dynamic> json) {
    return GpsEntity(
      id: json['id'],
      chargeLevel: json['charge_level'],
      simNumber: json['sim_number'],
      childId: json['child_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'charge_level': chargeLevel,
        'sim_number': simNumber,
        'child_id': childId,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

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
