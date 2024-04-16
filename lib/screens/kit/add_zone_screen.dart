import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:geolocator/geolocator.dart';

class AddZoneScreen extends StatefulWidget {
  const AddZoneScreen({super.key});

  @override
  State<AddZoneScreen> createState() => _AddZoneScreenState();
}

class _AddZoneScreenState extends State<AddZoneScreen> {
  List<LatLng> generatedPoints = [];
  TextEditingController zoneNameController = TextEditingController();
  TextEditingController radiusController = TextEditingController();
  late Position currentPosition;
  Marker? marker;
  final Completer<GoogleMapController> _mapsController =
      Completer<GoogleMapController>();

  // String mapStyle = jsonEncode(
  //   [
  //     {
  //       "featureType": "poi",
  //       "elementType": "labels",
  //       "stylers": [
  //         {"visibility": "off"}
  //       ]
  //     },
  //     {
  //       "elementType": "geometry",
  //       "stylers": [
  //         {"color": "#242f3e"}
  //       ]
  //     },
  //     {
  //       "elementType": "geometry",
  //       "stylers": [
  //         {"color": "#242f3e"}
  //       ]
  //     },
  //     {
  //       "elementType": "labels.text.stroke",
  //       "stylers": [
  //         {"color": "#242f3e"}
  //       ]
  //     },
  //     {
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#746855"}
  //       ]
  //     },
  //     {
  //       "featureType": "administrative.locality",
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#d59563"}
  //       ],
  //     },
  //     {
  //       "featureType": "poi",
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#d59563"}
  //       ],
  //     },
  //     {
  //       "featureType": "poi.park",
  //       "elementType": "geometry",
  //       "stylers": [
  //         {"color": "#263c3f"}
  //       ],
  //     },
  //     {
  //       "featureType": "poi.park",
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#6b9a76"}
  //       ],
  //     },
  //     {
  //       "featureType": "road",
  //       "elementType": "geometry",
  //       "stylers": [
  //         {"color": "#38414e"}
  //       ],
  //     },
  //     {
  //       "featureType": "road",
  //       "elementType": "geometry.stroke",
  //       "stylers": [
  //         {"color": "#212a37"}
  //       ],
  //     },
  //     {
  //       "featureType": "road",
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#9ca5b3"}
  //       ],
  //     },
  //     {
  //       "featureType": "road.highway",
  //       "elementType": "geometry",
  //       "stylers": [
  //         {"color": "#746855"}
  //       ],
  //     },
  //     {
  //       "featureType": "road.highway",
  //       "elementType": "geometry.stroke",
  //       "stylers": [
  //         {"color": "#1f2835"}
  //       ],
  //     },
  //     {
  //       "featureType": "road.highway",
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#f3d19c"}
  //       ],
  //     },
  //     {
  //       "featureType": "transit",
  //       "elementType": "geometry",
  //       "stylers": [
  //         {"color": "#2f3948"}
  //       ],
  //     },
  //     {
  //       "featureType": "transit.station",
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#d59563"}
  //       ],
  //     },
  //     {
  //       "featureType": "water",
  //       "elementType": "geometry",
  //       "stylers": [
  //         {"color": "#17263c"}
  //       ],
  //     },
  //     {
  //       "featureType": "water",
  //       "elementType": "labels.text.fill",
  //       "stylers": [
  //         {"color": "#515c6d"}
  //       ],
  //     },
  //     {
  //       "featureType": "water",
  //       "elementType": "labels.text.stroke",
  //       "stylers": [
  //         {"color": "#17263c"}
  //       ],
  //     },
  //   ],
  // );

  /* @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
 */
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 249, 255),
      appBar: buildAppBar(),
      //bottomNavigationBar: buildBottomNavigationBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: double.infinity,
            color: Colors.white,
            child: FieldInput(
              title: "Zone Name",
              controller: zoneNameController,
              validator: (value) {
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: double.infinity,
            color: Colors.white,
            child: Text("Tap on the map to add reference point to your zone",
                style: Theme.of(context).textTheme.titleSmall),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  // compassEnabled: false,
                  mapType: MapType.normal,
                  // style: mapStyle,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    _mapsController.complete(controller);
                  },
                  onTap: (position) {
                    setState(() {
                      marker = Marker(
                        markerId: const MarkerId("destination"),
                        position: position,
                        flat: true,
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue,
                        ),
                      );
                    });
                    print(position);
                  },
                  circles: {
                    if (marker != null && radiusController.text.isNotEmpty)
                      Circle(
                        circleId: const CircleId("source"),
                        center: marker!.position,
                        radius: double.parse(radiusController.text),
                        fillColor: Colors.blue.withOpacity(0.3),
                        strokeColor: Colors.blue,
                        strokeWidth: 1,
                      )
                  },
                  initialCameraPosition: const CameraPosition(
                      target: LatLng(3.8480, 11.5021), zoom: 14.5),
                  markers: {
                    if (marker != null) marker!,
                  },
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: IconButton(
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    icon: Icon(
                      Icons.my_location_outlined,
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                      Colors.white,
                    )),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 80, top: 20, left: 30, right: 30),
            width: double.infinity,
            color: Colors.white,
            child: FieldInput(
              title: "Radius (m)",
              controller: radiusController,
              onChanged: (p0) {
                setState(() {});
              },
              formatter: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              inputType: TextInputType.number,
              validator: (value) {
                return null;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FilledButton(
                style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(13)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                onPressed: () {},
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Text("Add Zone", style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Future<void> _getCurrentLocation() async {
    var position = await _determinePosition();
    if (position == null) {
      return;
    }
    currentPosition = position;
    var controller = await _mapsController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }
}

class SaveZoneItem extends StatelessWidget {
  const SaveZoneItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 2,
                  runSpacing: 5,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Lon : 8.1051",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Lat : 11.2181",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Radius : 200 m",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Zone 1",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
