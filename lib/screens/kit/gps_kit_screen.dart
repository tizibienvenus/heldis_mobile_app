import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/kit_screen.dart';
import 'package:heldis/screens/kit/gps_kit_details_screen.dart';

class GPSKitScreen extends StatefulWidget {
  const GPSKitScreen({super.key});

  @override
  State<GPSKitScreen> createState() => _GPSKitScreenState();
}

class _GPSKitScreenState extends State<GPSKitScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GPSKitDetailsScreen()),
                  );
                },
                child: const SelectedGPSKitItem(),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GPSKitDetailsScreen()),
                  );
                },
                child: const GPSKitItem(),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GPSKitDetailsScreen()),
                  );
                },
                child: const GPSKitItem(),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KitScreen(),
                      ));
                },
                child: const Text("Add GPS Kit"),
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
      title: Text("GPS Kit Profiles",
          style: Theme.of(context).textTheme.titleMedium),
      leading: const SizedBox(),
    );
  }
}

class SelectedGPSKitItem extends StatelessWidget {
  const SelectedGPSKitItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(children: [
            Image.asset(
              "assets/heldis.png",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "01202165106265165010651506032006",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "John Doe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
        const Positioned(
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Icon(
              Icons.check_circle_rounded,
              size: 25,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}

class GPSKitItem extends StatelessWidget {
  const GPSKitItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(children: [
        Image.asset(
          "assets/heldis.png",
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "01202165106265165010651506032006",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "John Doe",
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
