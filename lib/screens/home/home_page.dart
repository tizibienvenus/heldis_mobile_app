import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/home/components/bat_utills.dart';

class HomePage extends StatefulWidget{
  HomePage({this.batUtills, super.key});
  BatUtils? batUtills;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     /*  floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.share)
          ),
          FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.share)
          ),
          FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.share)
          )
        ],
      ),
       */
      bottomNavigationBar: buildBottomBar(context),

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
          /* Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: buildTopBar()
          ), */
          //bottomBar()
        ],
      ),
    
    );
  }

  AppBar buildAppBar(){
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //toolbarHeight: 80,
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
        actions: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                 /*  height: double.infinity,
                  width: double.infinity, */
                  margin: EdgeInsets.all(kDefaultPadding / 8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(kDefaultPadding,),
                   /*  image: const DecorationImage(
                      image: AssetImage("assets/images/genyco.png"),
                    ) */
                  ),
                  child: Image.asset(
                    "assets/images/gps.png",
                    height: kDefaultPadding / 1.5,
                  ),
                ),
                Text(
                  'En ligne', 
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                /* Text.rich(
                  TextSpan(
                    text: '. ', 
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.green, fontSize: 20),
                    children: [
                      TextSpan(
                        text: 'En ligne', 
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ), */
              ],
            ),
          ),
          const SizedBox(width: kDefaultPadding / 2,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                 /*  height: double.infinity,
                  width: double.infinity, */
                  margin: EdgeInsets.all(kDefaultPadding / 8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(kDefaultPadding,),
                   /*  image: const DecorationImage(
                      image: AssetImage("assets/images/genyco.png"),
                    ) */
                  ),
                  child: BatUtils?.getBatIcon(BatState.Full),
                ),
                Text(
                  "100 %",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: kDefaultPadding / 2,)
        ],
      );
      
  }

   Container buildBottomBar(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        height: 180,
        width: MediaQuery.of(context).size.width,
        decoration:const  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
             topRight: Radius.circular(30)
          )
        ),
        child: Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 7,
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 223, 221, 221),
                    borderRadius: BorderRadius.circular(50)
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2,),
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
      );

  }

}

class bottomBar extends StatelessWidget {
  const bottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}