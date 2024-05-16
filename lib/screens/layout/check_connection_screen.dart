import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/presentation/kit_screen.dart';
import 'package:heldis/screens/authentification/presentation/login.dart';
import 'package:heldis/screens/home.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';

class CheckConnectionScreen extends StatefulWidget {
  const CheckConnectionScreen({super.key});

  @override
  State<CheckConnectionScreen> createState() => _CheckConnectionScreenState();
}

class _CheckConnectionScreenState extends State<CheckConnectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnexionState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<ConnexionBloc>().state.token != null
        ? ((context.watch<ConnexionBloc>().state.user?.children?.isEmpty ??
                true)
            ? const KitScreen()
            : const HomeScreen())
        : const LoginScreen();
  }

  initConnexionState() {
    context.read<ConnexionBloc>().add(ConnexionLoadEvent(
          user: box.read('user') != null
              ? UserEntity.fromJson(box.read('user'))
              : null,
          token: box.read('token'),
        ));
  }
}
