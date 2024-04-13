import 'package:flutter/material.dart';
import 'package:heldis/screens/history/history.dart';
import 'package:heldis/screens/home/home_page.dart';
import 'package:heldis/screens/profile/Tizi.dart';
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
    HomePage(),
    HistoryView(),
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
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: pages[currentIndex],
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
        BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Forum"),
        
      ],
    );
  }
}
