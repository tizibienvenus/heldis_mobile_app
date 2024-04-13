/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MaspView extends StatefulWidget {
  const MaspView({Key? key, required this.sourceLocation, required this.order,}) : super(key: key);
  final Order order;
  final LatLng sourceLocation;

  @override
  State<MaspView> createState() => MaspViewState();
}

class MaspViewState extends State<MaspView> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GoogleMap(
          compassEnabled: false,
          mapToolbarEnabled: false,
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: widget.order.position, zoom: 13.5),
          markers: {
            Marker(
              markerId: MarkerId("source"),
              position: widget.order.position,
            ),
             Marker(
              markerId: MarkerId("destination"),
              position: widget.order.position,
            ),
          },
        ),
      ),
    );
  }
}
*/
