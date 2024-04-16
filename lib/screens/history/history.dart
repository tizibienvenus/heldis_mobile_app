import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> generatedPoints = [];
  TextEditingController dateEnd = TextEditingController();
  TextEditingController dateStart = TextEditingController();
  /* @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
 */

  List<LatLng> generatePointsAround(
      LatLng center, int distanceInMeter, int count) {
    final maxDistanceInMeter = 20;
    const pi = 3.14159265358979323846;
    LatLng currentLocation = center;
    final points = <LatLng>[];
    final random = Random();

    for (var i = 0; i < count; i++) {
      final angle = random.nextDouble() * 2 * pi;
      final dx = (random.nextDouble() - 0.5) * 2 * maxDistanceInMeter;
      final dy = (random.nextDouble() - 0.5) * 2 * maxDistanceInMeter;

      currentLocation = LatLng(
          currentLocation.latitude + dy / 111325,
          currentLocation.longitude +
              dx / (111325 * cos(center.latitude * pi / 180)));

      points.add(LatLng(currentLocation.latitude, currentLocation.longitude));
    }
    return points;
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      //bottomNavigationBar: buildBottomNavigationBar(),
      body: Stack(
        children: [
          GoogleMap(
            compassEnabled: false,
            mapToolbarEnabled: false,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            polylines: {
              Polyline(
                  polylineId: const PolylineId("route"),
                  color: Colors.blue,
                  width: 5,
                  points: [
                    const LatLng(3.8480, 11.5021),
                    ...generatePointsAround(
                        const LatLng(3.8480, 11.5021), 500, 50)
                  ])
            },
            initialCameraPosition: const CameraPosition(
                target: LatLng(3.8480, 11.5021), zoom: 17.5),
            markers: {
              const Marker(
                markerId: MarkerId("source"),
                position: LatLng(3.8480, 11.5021),
              ),
              const Marker(
                // icon:
                markerId: MarkerId("destination"),
                position: LatLng(3.7480, 11.5021),
              ),
            },
          ),
          /* Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: buildTopBar()
          ), */
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              //margin: EdgeInsets.all(20),
              //height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: dateStart,
                          readOnly: true,
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                            if (picked == null) {
                              return;
                            }
                            final TimeOfDay? pickedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            if (pickedTime == null) {
                              return;
                            }
                            dateStart.text =
                                "${picked.year}/${picked.month}/${picked.day} - ${pickedTime.hour}:${pickedTime.minute}";
                          },
                          decoration: InputDecoration(
                            hintText: "Start Date",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 9.0, horizontal: 10.0),
                            labelStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: dateEnd,
                          readOnly: true,
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2015, 8),
                                lastDate: DateTime(2101));
                            if (picked == null) {
                              return;
                            }
                            final TimeOfDay? pickedTime = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());

                            if (pickedTime == null) {
                              return;
                            }
                            dateEnd.text =
                                "${picked.year}/${picked.month}/${picked.day} - ${pickedTime.hour}:${pickedTime.minute}";
                          },
                          decoration: InputDecoration(
                            hintText: "End Date",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 9.0, horizontal: 10.0),
                            labelStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text("History", style: Theme.of(context).textTheme.titleMedium),
      leading: SizedBox(),
    );
  }

  Container buildTopBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          const SizedBox(
            width: 5,
          ),
          const Text("Tizi Demo"),
          const Spacer(),
          const Row(
            children: [
              Column(
                children: [
                  //BatUtils.getBatIcon(BatState.Full),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
