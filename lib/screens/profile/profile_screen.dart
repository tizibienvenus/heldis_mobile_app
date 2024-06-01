import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/common/widgets/payment_view.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/authentification/presentation/login.dart';
import 'package:heldis/screens/layout/check_connection_screen.dart';
import 'package:heldis/screens/profile/blocs/handle_profile/handle_profile_bloc.dart';
import 'package:heldis/screens/profile/change_password_screen.dart';
import 'package:heldis/screens/profile/components/premium_card.dart';
import 'package:heldis/screens/profile/edit_profile_screen.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> listInfo = [
    "Edit Profil",
    "Change Password",
    "Summary",
    "About Us",
    "Help Center",
    "Logout",
    "Delete Your Account",
  ];

  List<IconData> listIcons = [
    Icons.person,
    Icons.password,
    Icons.article,
    Icons.info,
    Icons.help,
    Icons.logout,
    Icons.close,
  ];

  List<String> AIlistInfo = [
    "Doctor Assistance",
    "AI Assistance",
  ];

  List<IconData> AIlistIcons = [
    Icons.assistant_sharp,
    Icons.local_atm,
  ];

  List<Function> listMethod(BuildContext context) {
    return [
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProfileScreen(),
          ),
        );
      },
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChangePasswordScreen(),
          ),
        );
      },
      () {},
      () {},
      () {},
      () {
        box.remove('token');
        box.remove('user');

        context.read<AuthBloc>().add(LogoutEvent());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
      () async {
        var res = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm'),
            content: const Text(
              'Are you sure you want to delete your account ? this action cannot be undone.',
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
              TextButton(
                onPressed: () async {
                  context.read<HandleProfileBloc>().add(DeleteProfileEvent());
                  var res = await showDialog(
                    context: context,
                    builder: (context) {
                      return WillPopScope(
                        onWillPop: () async => (context
                            .read<HandleProfileBloc>()
                            .state is! DeleteProfileLoading),
                        child:
                            BlocListener<HandleProfileBloc, HandleProfileState>(
                          listener: (context, state) {
                            if (state is DeleteProfileSuccess) {
                              box.remove('token');
                              box.remove('user');
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false,
                              );
                            }
                            if (state is DeleteProfileError) {
                              Navigator.of(context).pop('Error');
                            }
                          },
                          child: const AlertDialog(
                            content: IntrinsicHeight(
                              child: Column(
                                children: <Widget>[
                                  CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  Navigator.of(context).pop(res);
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
        );

        if (res == 'Error') {
          showErrorSnackBar(context: context, message: 'Error during deletion');
        }
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserBloc, GetUserState>(
      listener: (context, state) {
        if (state is GetUserSuccess) {
          context.read<ConnexionBloc>().add(
                ConnexionLoadEvent(
                  user: state.user,
                  token: box.read('token'),
                ),
              );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: buildAppBar(context),
        body: context.watch<GetUserBloc>().state is GetUserLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((context
                              .watch<ConnexionBloc>()
                              .state
                              .user
                              ?.subscriptionIsActive !=
                          SubscriptionStatus.active))
                        const PaymentView(),
                      // const SizedBox(
                      //   height: kDefaultPadding,
                      // ),
                      Row(
                        children: [
                          if (context
                                  .watch<ConnexionBloc>()
                                  .state
                                  .user
                                  ?.avatar
                                  ?.isEmpty ??
                              true)
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(150),
                              ),
                              child: Image.asset(
                                "assets/heldis.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(150),
                              ),
                              child: Image.memory(
                                base64Decode(context
                                    .watch<ConnexionBloc>()
                                    .state
                                    .user!
                                    .avatar!),
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(
                            width: kDefaultPadding,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                          .watch<ConnexionBloc>()
                                          .state
                                          .user
                                          ?.name ??
                                      "",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(
                                  context
                                          .watch<ConnexionBloc>()
                                          .state
                                          .user
                                          ?.email ??
                                      "",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(kDefaultPadding / 3),
                        ),
                        child: BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is LogoutSuccess) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CheckConnectionScreen(),
                                ),
                                (route) => false,
                              );
                            }

                            if (state is LoginError) {
                              showErrorSnackBar(
                                  context: context, message: state.message);
                            }
                          },
                          child: Column(
                            children: List.generate(
                              listIcons.length,
                              (index) => ListTile(
                                leading: Icon(
                                  listIcons[index],
                                  size: 20,
                                  // color: kPrimaryColor,
                                ),
                                title: Text(
                                  listInfo[index],
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                onTap: () {
                                  listMethod(context)[index]();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      title: const Text(
        "Profile",
      ),
    );
  }
}
