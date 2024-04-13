import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/home.dart';
import 'package:heldis/screens/home/home_page.dart';
import 'package:open_whatsapp/open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';



class GPSConnectView extends StatefulWidget {
  GPSConnectView({Key? key}) : super(key: key);

  @override
  State<GPSConnectView> createState() => _GPSConnectViewState();
}

class _GPSConnectViewState extends State<GPSConnectView> {
  late TextEditingController phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final state = context.watch<AuthenticationState>();
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding * 5),
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Text(
                  "GPS Connection",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Text.rich(
                  TextSpan(
                    text: "Veuillez entrer le numéro sur le kit GPS",  // Corrected text
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(  // Applying style from the current theme
                      color: Colors.black54,  // Text color
                      fontWeight: FontWeight.normal,  // Text weight
                    ),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ), // Espacement entre les champs
                Center(
                  child: FieldInput(
                    title: "Numero kit GPS",
                    controller: phoneNumberController,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: (){
                          Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context)=> HomeScreen())
                          );
                        },
                        child: Text("Continue"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text:
                        "Vous n'avez pas de kit GPS ?",
                        children: [
                          TextSpan(
                            text: "\nCommander ici",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor, // Utilisez la couleur principale de l'application
                            ),
                            //style: DefaultTextStyle.of(context).style,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                navigateToWhatsApp("+237691951267");
                              },
                          ),

                        ]
                      ),

                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ));
  }

  void navigateToWhatsApp(String phoneNumber) async {
    FlutterOpenWhatsapp.sendSingleMessage(phoneNumber, "Hello");
    /*String whatsappUrl = "whatsapp://send?phone=$phoneNumber";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      // Handle error: WhatsApp is not installed
      print('Could not launch $whatsappUrl');
    }*/
  }
}
