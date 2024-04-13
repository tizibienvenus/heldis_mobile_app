import 'package:flutter/material.dart';
import 'package:heldis/screens/authentification/login.dart';
import 'package:heldis/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Example',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,
      //home: UserHome(),
      home: OmboardView(),
    );
  }
}
