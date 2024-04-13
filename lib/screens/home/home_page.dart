import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/constants/constants.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  
   /* @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
 */
   @override
  void initState() {
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){
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
              initialCameraPosition:
                  CameraPosition(target: LatLng(3.8480, 11.5021), zoom: 13.5),
              markers: {
                Marker(
                  markerId: MarkerId("source"),
                  position: LatLng(3.8480, 11.5021),
                ),
                 Marker(
                 // icon: 
                  markerId: MarkerId("destination"),
                  position: LatLng(3.7480, 11.5021),
                ),
              },
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
            padding: EdgeInsets.all(20),
              //margin: EdgeInsets.all(20),
              //height: 150,
              width: MediaQuery.of(context).size.width,
              decoration:const  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                   topRight: Radius.circular(30)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RGP7+F5Q, Yaoundé",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    "Mis à jour il y'a 1 minute",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                      child: FilledButton(
                        onPressed: (){
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPVerificationView(),
                          ),); */
                        },
                        child: Text("Live"),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: FilledButton(
                        onPressed:null,
                        // (){
                         /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OTPVerificationView(),
                          ),); */
                       // },
                        child: Text("Radar"),
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
    
    );
  }

  AppBar buildAppBar(){
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: ClipRRect(
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/genyco.png"
                  ),
                ),
              ),
              onPressed: () {
               // Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      );
      
  }

  Container buildBottomNavigationBar (){
    return Container(
     // padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("data"),
          Text("data")
        ],
      ),
    );
  }
}