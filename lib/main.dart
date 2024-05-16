import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/register_kit/register_kit_bloc.dart';
import 'package:heldis/screens/home.dart';
import 'package:heldis/screens/layout/check_connection_screen.dart';
import 'package:heldis/services/bloc_list.dart';
import 'package:heldis/services/services_injection.dart';
import 'package:heldis/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...blocProviderList,
      ],
      child: MaterialApp(
        title: 'Google Maps Example',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        themeMode: ThemeMode.light,
        // home: HomeScreen(),
        home: const CheckConnectionScreen(),
      ),
    );
  }
}
