import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/profile/components/premium_card.dart';

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
    "Settings",
  ];

  List<IconData> listIcons = [
    Icons.person,
    Icons.article,
    Icons.info,
    Icons.help,
    Icons.settings
  ];

  List<String> AIlistInfo = [
    "Doctor Assistance",
    "AI Assistance",
  ];

  List<IconData> AIlistIcons = [
    Icons.assistant_sharp,
    Icons.local_atm,
  ];

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
              Text(
                "Premium",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(),
              ),
              const SizedBox(
                height: kDefaultPadding / 2,
              ),
              const PremiumCard(),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kDefaultPadding / 3),
                ),
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
                        // Action à exécuter lorsqu'un ListTile est cliqué
                        print('Tapped on ${listInfo[index]}');
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(
                "Other Service",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontFamily: "Montserrat",
                    ),
              ),
              const SizedBox(
                height: kDefaultPadding / 2,
              ),
              Container(
                padding: EdgeInsets.all(kDefaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(kDefaultPadding / 3),
                ),
                child: Column(
                  children: List.generate(
                    AIlistIcons.length,
                    (index) => ListTile(
                      leading: Icon(
                        AIlistIcons[index],
                        size: 20,
                        // color: kPrimaryColor,
                      ),
                      title: Text(
                        AIlistInfo[index],
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      onTap: () {
                        // Action à exécuter lorsqu'un ListTile est cliqué
                        print('Tapped on ${listInfo[index]}');
                      },
                    ),
                  ),
                ),
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
