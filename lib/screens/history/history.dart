import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: builAppBar(),
      body: Container(
        color: Color(0xFFF8F8F8),
        child: Center(child: Text("Child's History")),
      ),
    );
  }

  AppBar builAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Child's History"),
    );
  }
}