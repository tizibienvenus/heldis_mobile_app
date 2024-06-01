import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/common/widgets/payment_view.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/history/blocs/get_coordinate_history/get_coordinate_history_bloc.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';
import 'package:heldis/services/session/selected_kit/selected_kit_bloc.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final Completer<GoogleMapController> _controller = Completer();
  // List<LatLng> generatedPoints = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateEnd = TextEditingController();
  TextEditingController dateStart = TextEditingController();
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
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      //bottomNavigationBar: buildBottomNavigationBar(),
      body: (context.watch<ConnexionBloc>().state.user?.subscriptionIsActive !=
              SubscriptionStatus.active)
          ? const SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: PaymentView())
          : BlocListener<GetCoordinateHistoryBloc, GetCoordinateHistoryState>(
              listener: (context, state) {
                if (state is GetCoordinateHistorySuccess) {
                  // generatedPoints.add(value);
                }
              },
              child: context.watch<SelectedKitBloc>().state.kitId == 0
                  ? const Center(
                      child: Text(
                      "Select a gps kit",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))
                  : Stack(
                      children: [
                        if (context.watch<GetCoordinateHistoryBloc>().state
                            is GetCoordinateHistorySuccess)
                          if ((context.watch<GetCoordinateHistoryBloc>().state
                                  as GetCoordinateHistorySuccess)
                              .coordinates
                              .isNotEmpty)
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
                                      ...(context
                                                  .watch<GetCoordinateHistoryBloc>()
                                                  .state
                                              as GetCoordinateHistorySuccess)
                                          .coordinates
                                          .map((e) => LatLng(
                                              double.parse(e.latitude ?? '0'),
                                              double.parse(e.longitude ?? '0')))
                                    ])
                              },
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      double.parse((context
                                                      .watch<
                                                          GetCoordinateHistoryBloc>()
                                                      .state
                                                  as GetCoordinateHistorySuccess)
                                              .coordinates
                                              .firstOrNull
                                              ?.latitude ??
                                          '0'),
                                      double.parse((context
                                                      .watch<
                                                          GetCoordinateHistoryBloc>()
                                                      .state
                                                  as GetCoordinateHistorySuccess)
                                              .coordinates
                                              .firstOrNull
                                              ?.longitude ??
                                          '0')),
                                  zoom: 17.5),
                              markers: {
                                Marker(
                                  markerId: const MarkerId("source"),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueAzure,
                                  ),
                                  position: LatLng(
                                      double.parse((context
                                                      .watch<
                                                          GetCoordinateHistoryBloc>()
                                                      .state
                                                  as GetCoordinateHistorySuccess)
                                              .coordinates
                                              .firstOrNull
                                              ?.latitude ??
                                          '0'),
                                      double.parse((context
                                                      .watch<
                                                          GetCoordinateHistoryBloc>()
                                                      .state
                                                  as GetCoordinateHistorySuccess)
                                              .coordinates
                                              .firstOrNull
                                              ?.longitude ??
                                          '0')),
                                )
                              },
                            )
                          else
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.all(20),
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Text(
                                    "History is empty, change date range",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        if (context.watch<GetCoordinateHistoryBloc>().state
                            is GetCoordinateHistoryLoading)
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.all(50),
                              child: const Column(
                                  children: [CircularProgressIndicator()])),
                        if (context.watch<GetCoordinateHistoryBloc>().state
                            is GetCoordinateHistoryInitial)
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: const Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                ),
                                Text(
                                  "Search last position of gps",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (context.watch<GetCoordinateHistoryBloc>().state
                            is GetCoordinateHistoryFailure)
                          Container(
                            padding: const EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 70,
                                ),
                                const Text(
                                  "Error occurred, please try again",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  (context
                                          .watch<GetCoordinateHistoryBloc>()
                                          .state as GetCoordinateHistoryFailure)
                                      .message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                            controller: dateStart,
                                            readOnly: true,
                                            onTap: () async {
                                              final DateTime? picked =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate:
                                                          DateTime(2015, 8),
                                                      lastDate: DateTime(2101));
                                              if (picked == null) {
                                                return;
                                              }
                                              final TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now());

                                              if (pickedTime == null) {
                                                return;
                                              }
                                              print(picked.toString());
                                              dateStart.text =
                                                  "${picked.year}-${picked.month.toString().length == 1 ? "0${picked.month}" : picked.month}-${picked.day.toString().length == 1 ? "0${picked.day}" : picked.day} ${pickedTime.hour.toString().length == 1 ? "0${pickedTime.hour}" : pickedTime.hour}:${pickedTime.minute.toString().length == 1 ? "0${pickedTime.minute}" : pickedTime.minute}";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Start Date",
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 10.0),
                                              labelStyle: const TextStyle(
                                                  color: Colors.grey),
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              if (dateEnd.text.isNotEmpty &&
                                                  dateStart.text.isNotEmpty) {
                                                final startDate =
                                                    DateTime.parse(
                                                        dateStart.text.trim() +
                                                            ":00");
                                                final endDate = DateTime.parse(
                                                    dateEnd.text.trim() +
                                                        ":00");
                                                if (endDate
                                                    .isBefore(startDate)) {
                                                  return 'End date must be after start date.';
                                                }
                                              }
                                              return null;
                                            }),
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
                                              final DateTime? picked =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate:
                                                          DateTime(2015, 8),
                                                      lastDate: DateTime(2101));
                                              if (picked == null) {
                                                return;
                                              }
                                              final TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now());

                                              if (pickedTime == null) {
                                                return;
                                              }
                                              dateEnd.text =
                                                  "${picked.year}-${picked.month.toString().length == 1 ? "0${picked.month}" : picked.month}-${picked.day.toString().length == 1 ? "0${picked.day}" : picked.day} ${pickedTime.hour.toString().length == 1 ? "0${pickedTime.hour}" : pickedTime.hour}:${pickedTime.minute.toString().length == 1 ? "0${pickedTime.minute}" : pickedTime.minute}";
                                            },
                                            decoration: InputDecoration(
                                              hintText: "End Date",
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 9.0,
                                                      horizontal: 10.0),
                                              labelStyle: const TextStyle(
                                                  color: Colors.grey),
                                              filled: true,
                                              fillColor: Colors.grey[200],
                                              border: const OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter some text';
                                              }
                                              if (dateEnd.text.isNotEmpty &&
                                                  dateStart.text.isNotEmpty) {
                                                final startDate =
                                                    DateTime.parse(
                                                        dateStart.text.trim() +
                                                            ":00.0000");
                                                final endDate = DateTime.parse(
                                                    dateEnd.text.trim() +
                                                        ":00.0000");
                                                if (endDate
                                                    .isBefore(startDate)) {
                                                  return 'End date must be after start date.';
                                                }
                                              }
                                              return null;
                                            }),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context
                                            .read<GetCoordinateHistoryBloc>()
                                            .add(GetCoordinateHistory(
                                              dateStart: dateStart.text,
                                              dateEnd: dateEnd.text,
                                            ));
                                      }
                                    },
                                    child: const Text("Search"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text("History", style: Theme.of(context).textTheme.titleMedium),
      leading: const SizedBox(),
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
