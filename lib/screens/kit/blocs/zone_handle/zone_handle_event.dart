part of 'zone_handle_bloc.dart';

sealed class ZoneHandleEvent extends Equatable {
  const ZoneHandleEvent();

  @override
  List<Object> get props => [];
}

class AddZoneEvent extends ZoneHandleEvent {
  final String zoneName;
  final int radius;
  final double lat;
  final double lng;
  final int childId;
  const AddZoneEvent({
    required this.zoneName,
    required this.radius,
    required this.lat,
    required this.lng,
    required this.childId,
  });

  @override
  List<Object> get props => [zoneName, radius, lat, lng, childId];
}

class DeleteZoneEvent extends ZoneHandleEvent {
  final int childId;
  final int zoneId;
  const DeleteZoneEvent({
    required this.zoneId,
    required this.childId,
  });

  @override
  List<Object> get props => [zoneId, childId];
}
