import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/otp_verification.dart';

class OmboardView extends StatelessWidget {
  OmboardView({Key? key}) : super(key: key);

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
                "Welcome",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Text(
                "Log In",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(
                flex: 1,
              ), // Espacement entre les champs
              FieldInput(
                title: "Numero de Téléphone",
                controller: phoneNumberController,
                inputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const Spacer(
                flex: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPVerificationView(),
                          ),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Continuer avec ",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundColor: kContentColorDarkTheme,
                    child: IconButton(
                        onPressed: () {
                          //final state = context.read<AuthenticationState>();
                          //state.googleSingin();
                        },
                        icon: SvgPicture.asset("assets/icons/google.svg")),
                  ),
                  CircleAvatar(
                    backgroundColor: kContentColorDarkTheme,
                    child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/envelope.svg",
                        )),
                  )
                ],
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
