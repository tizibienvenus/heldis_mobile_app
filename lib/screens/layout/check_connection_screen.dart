import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/authentification/presentation/kit_screen.dart';
import 'package:heldis/screens/authentification/presentation/login.dart';
import 'package:heldis/screens/home.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';
import 'package:heldis/services/session/selected_kit/selected_kit_bloc.dart';

class CheckConnectionScreen extends StatefulWidget {
  const CheckConnectionScreen({super.key});

  @override
  State<CheckConnectionScreen> createState() => _CheckConnectionScreenState();
}

class _CheckConnectionScreenState extends State<CheckConnectionScreen> {
  @override
  void initState() {
    super.initState();
    initConnexionState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetUserBloc, GetUserState>(
          listener: (context, state) {
            if (state is GetUserSuccess) {
              context.read<ConnexionBloc>().add(ConnexionLoadEvent(
                  user: state.user, token: box.read("token")));
            }
          },
        ),
        BlocListener<GetChildrenBloc, GetChildrenState>(
          listener: (context, state) {
            if (state is GetChildrenSuccess) {
              context.read<SelectedKitBloc>().add(ChangeSelectedKitEvent(
                  kit: state.children.firstOrNull?.id ?? 0));
            }
          },
        ),
      ],
      child: BlocBuilder<GetUserBloc, GetUserState>(builder: (context, state) {
        if (state is GetUserLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return context.watch<ConnexionBloc>().state.token != null
            ? ((context.watch<ConnexionBloc>().state.user?.children?.isEmpty ??
                    true)
                ? const KitScreen()
                : const HomeScreen())
            : const LoginScreen();
      }),
    );
  }

  initConnexionState() {
    if (box.read("token") != null) {
      context.read<GetUserBloc>().add(const GetUser());
      context.read<GetChildrenBloc>().add(const GetChildren());
    }
  }
}
