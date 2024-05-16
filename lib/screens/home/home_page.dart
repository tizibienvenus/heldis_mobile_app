import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/common/widgets/payment_view.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> generatedPoints = [];
  double safeArea = 1000;
  /* @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
 */

  List<LatLng> generatePointsAround(
      LatLng center, int distanceInMeter, int count) {
    final maxDistanceInMeter = distanceInMeter;
    const pi = 3.14159265358979323846;
    final points = <LatLng>[];
    final random = Random();

    for (var i = 0; i < count; i++) {
      final angle = random.nextDouble() * 2 * pi;
      final distance = random.nextDouble() * maxDistanceInMeter;
      final dx = distance * cos(angle);
      final dy = distance * sin(angle);
      points.add(LatLng(center.latitude + dy / 111325,
          center.longitude + dx / (111325 * cos(center.latitude * pi / 180))));
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
    return GestureDetector(
      // onTap: () => context.read<GetUserBloc>().add(const GetUser()),
      onTap: () =>
          print(context.read<ConnexionBloc>().state.user?.subscriptionIsActive),
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
            ? SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: PaymentView(),
              )
            : Stack(
                children: [
                  GoogleMap(
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
                      Circle(
                        circleId: const CircleId("source"),
                        center: const LatLng(3.8480, 11.5021),
                        radius: 1000,
                        fillColor: Colors.blue.withOpacity(0.3),
                        strokeColor: Colors.blue,
                        strokeWidth: 1,
                      )
                    },
                    initialCameraPosition: const CameraPosition(
                        target: LatLng(3.8480, 11.5021), zoom: 14.5),
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
                          Text(
                            "RGP7+F5Q, Yaoundé",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Mis à jour il y'a 1 minute",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              FilledButton(
                                onPressed: () {},
                                child: const Text("Live"),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Expanded(
                                child: FilledButton(
                                  onPressed: null,
                                  // (){
                                  /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPVerificationView(),
                            ),); */
                                  // },
                                  child: Text("Safe Area (1000m)"),
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
            icon: const ClipRRect(
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/genyco.png"),
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
        const Text("Connecte"),
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
