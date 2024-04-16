import 'package:flutter/material.dart';
import 'package:heldis/screens/history/components/history_card.dart';

class HistoryView extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: builAppBar(),
      body: ListView.builder(
        itemCount: 15, 
        itemBuilder: (BuildContext context, int index) {
        return HistoryCard();
  },
)

    );
  }

  AppBar builAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Child's History"),
    );
  }
}