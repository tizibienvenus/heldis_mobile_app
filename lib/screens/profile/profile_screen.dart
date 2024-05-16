import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/common/widgets/payment_view.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/layout/check_connection_screen.dart';
import 'package:heldis/screens/profile/components/premium_card.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> listInfo = [
    "Profil",
    "Summary",
    "About Us",
    "Help Center",
    "Logout",
  ];

  List<IconData> listIcons = [
    Icons.person,
    Icons.article,
    Icons.info,
    Icons.help,
    Icons.logout,
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
      () {},
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
            builder: (context) => const CheckConnectionScreen(),
          ),
          (route) => false,
        );
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
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
                PaymentView(),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kDefaultPadding / 3),
                ),
                child: BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is LogoutSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckConnectionScreen(),
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
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Text(
        "Profile",
      ),
    );
  }
}
