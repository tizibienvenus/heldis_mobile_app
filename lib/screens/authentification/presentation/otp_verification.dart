import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/presentation/connect_gps.dart';
import 'package:pinput/pinput.dart';



class OTPVerificationView extends StatelessWidget {
  OTPVerificationView({Key? key}) : super(key: key);

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
                  "Verification",
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
                    text: "Veillez entrer un code que nous avons envoyé au 690909090",  // Corrected text
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
                  child: Pinput(
                    length: 6,

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
                            MaterialPageRoute(
                              builder: (context) => GPSConnectView(),
                            ),);
                        },
                        child: Text("Continue"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ));
  }

}
