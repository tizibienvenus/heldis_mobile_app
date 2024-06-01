import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: builAppBar(),
      body: Container(
        color: Color(0xFFF8F8F8),
        child: Center(child: Text("Father's Profile")),
      ),
    );
  }

  AppBar builAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Father's Profile"),
    );
  }
}