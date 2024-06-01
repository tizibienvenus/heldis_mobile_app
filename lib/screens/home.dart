import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heldis/screens/history/history.dart';
import 'package:heldis/screens/home/home_page.dart';
import 'package:heldis/screens/kit/gps_kit_screen.dart';
import 'package:heldis/screens/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<HomeScreen> {
  late ScrollController controller;
  int currentIndex = 0;

  List pages = [
    const HomePage(),
    const HistoryView(),
    const GPSKitScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: buildBottomNavigationBar(),
          body: pages[currentIndex],
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 1,
      type: BottomNavigationBarType.fixed,
      //fixedColor: kPrimaryColor,
      currentIndex: currentIndex,
      enableFeedback: true,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month), label: "History"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_sharp), label: "Person"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
      ],
    );
  }
}
