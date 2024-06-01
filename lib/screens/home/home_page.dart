import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:widgets_to_image/widgets_to_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/common/widgets/payment_view.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/home/blocs/bloc/get_last_position_bloc.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';
import 'package:heldis/services/session/selected_kit/selected_kit_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  Uint8List? bytes;
  double safeArea = 1000;
  bool isLive = false;
  LatLng gpsPosition = const LatLng(3.8480, 11.5021);
  Timer? _timer;

  @override
  void initState() {
    setState(() {});
    super.initState();
    updateByte();
  }

  void _startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      context.read<GetLastPositionBloc>().add(const GetLastPosition());
    });
  }

  updateByte() async {
    if (context.read<SelectedKitBloc>().state.kitId == 0) {
      return;
    }
    WidgetsToImageController byteController = WidgetsToImageController();

    WidgetsToImage(
      controller: byteController,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: ClipOval(
          child: Image.memory(
            base64Decode(
                (context.watch<GetChildrenBloc>().state as GetChildrenSuccess)
                        .children
                        .firstWhere((element) =>
                            element.id ==
                            context.watch<SelectedKitBloc>().state.kitId)
                        .avatar ??
                    ""),
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
    var _bytes = await byteController.capture();

    setState(() {
      bytes = _bytes;
    });

    print(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetChildrenBloc, GetChildrenState>(
          listener: (context, state) {
            if (state is GetChildrenSuccess) {
              if (state.children.isNotEmpty) {
                if (context.read<SelectedKitBloc>().state.kitId != 0) {
                  updateByte();
                }
              }
            }
          },
        ),
        BlocListener<SelectedKitBloc, SelectedKitState>(
          listener: (context, state) {
            if (state is ChangeKitIdState) {
              if (state.kitId != 0) {
                updateByte();
              }
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        //bottomNavigationBar: buildBottomNavigationBar(),
        body: (context
                    .watch<ConnexionBloc>()
                    .state
                    .user
                    ?.subscriptionIsActive !=
                SubscriptionStatus.active)
            ? const SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PaymentView(),
              )
            : BlocListener<GetLastPositionBloc, GetLastPositionState>(
                listener: (context, state) {
                  if (state is GetLastPositionSuccess) {
                    setState(() {
                      gpsPosition = LatLng(
                          double.parse(
                              state.coordinate.latitude?.toString() ?? "0"),
                          double.parse(
                              state.coordinate.longitude?.toString() ?? "0"));
                    });

                    _controller.future.then((controller) {
                      controller.animateCamera(CameraUpdate.newLatLng(
                        gpsPosition,
                      ));
                    });
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
                          GoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            compassEnabled: false,
                            mapToolbarEnabled: false,
                            mapType: MapType.normal,
                            zoomControlsEnabled: false,
                            // polylines: {
                            //   Polyline(
                            //       polylineId: const PolylineId("route"),
                            //       color: Colors.blue,
                            //       width: 5,
                            //       points: [
                            //         const LatLng(3.8480, 11.5021),
                            //         ...generatePointsAround(
                            //             const LatLng(3.8480, 11.5021), 500, 8)
                            //       ])
                            // },
                            circles: {
                              ...((context.watch<GetChildrenBloc>().state
                                          as GetChildrenSuccess)
                                      .children
                                      .firstWhere((element) =>
                                          element.id ==
                                          context
                                              .watch<SelectedKitBloc>()
                                              .state
                                              .kitId)
                                      .zones
                                      ?.map(
                                        (e) => Circle(
                                          circleId: CircleId(e.id.toString()),
                                          center:
                                              LatLng(e.lat ?? 0, e.lng ?? 0),
                                          radius: 1000,
                                          fillColor:
                                              Colors.blue.withOpacity(0.3),
                                          strokeColor: Colors.blue,
                                          strokeWidth: 1,
                                        ),
                                      ) ??
                                  {}),
                            },
                            initialCameraPosition: const CameraPosition(
                                target: LatLng(3.8480, 11.5021), zoom: 14.5),
                            markers: {
                              Marker(
                                icon: bytes == null
                                    ? BitmapDescriptor.defaultMarker
                                    : BitmapDescriptor.fromBytes(bytes!),
                                markerId: const MarkerId("source"),
                                position: gpsPosition,
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
                                  // Text(
                                  //   "RGP7+F5Q, Yaoundé",
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .titleMedium!
                                  //       .copyWith(fontWeight: FontWeight.bold),
                                  // ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Text(
                                  //   "Mis à jour il y'a 1 minute",
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .bodyMedium!
                                  //       .copyWith(fontWeight: FontWeight.bold),
                                  // ),

                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      if (!isLive)
                                        FilledButton(
                                          onPressed: () {
                                            _startTimer(context);
                                            setState(() {
                                              isLive = true;
                                            });
                                          },
                                          child: const Text("Start Live"),
                                        )
                                      else
                                        FilledButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            _timer?.cancel();
                                            setState(() {
                                              isLive = false;
                                            });
                                          },
                                          child: const Text("Stop Live"),
                                        ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: FilledButton(
                                          onPressed: null,
                                          // (){
                                          /*  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OTPVerificationView(),
                                        ),); */
                                          // },
                                          child: Text((context
                                                          .watch<GetChildrenBloc>()
                                                          .state
                                                      as GetChildrenSuccess)
                                                  .children
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      context
                                                          .watch<
                                                              SelectedKitBloc>()
                                                          .state
                                                          .kitId)
                                                  .name ??
                                              "Select a gps kit"),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
              ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text("Welcome ${context.watch<ConnexionBloc>().state.user?.name}",
          style: Theme.of(context).textTheme.titleMedium),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: ClipRRect(
              child: context
                          .watch<ConnexionBloc>()
                          .state
                          .user
                          ?.avatar
                          ?.isEmpty ??
                      true
                  ? const CircleAvatar(
                      backgroundImage: AssetImage("assets/heldis.png"),
                      backgroundColor: Color.fromARGB(255, 216, 216, 216),
                    )
                  : CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(
                          context.watch<ConnexionBloc>().state.user?.avatar ??
                              "")),
                      backgroundColor: const Color.fromARGB(255, 216, 216, 216),
                    ),
            ),
            onPressed: () {
              // Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      actions: [
        Container(
          height: kDefaultPadding,
          margin: const EdgeInsets.all(kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(
                kDefaultPadding,
              ),
              image: const DecorationImage(
                image: AssetImage("assets/images/gps.png"),
              )),
        ),
        const Text("Connected", style: TextStyle(color: Colors.green)),
        const SizedBox(
          width: kDefaultPadding / 2,
        ),
      ],
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
