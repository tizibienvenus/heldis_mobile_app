import 'package:google_maps_flutter/google_maps_flutter.dart';

enum TypeZone {interdit, autorise}

class Zone{
  final String zid;
  final TypeZone typeZone;
  final int diameter;
  final LatLng position;

  const Zone({
    required this.zid,
    required this.typeZone,
    required this.diameter,
    required this.position,
  });
}