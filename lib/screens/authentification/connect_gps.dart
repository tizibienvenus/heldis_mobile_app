import 'package:flutter/material.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/home.dart';
import 'package:heldis/screens/home/home_page.dart';

class GPSConnectView extends StatefulWidget {
  GPSConnectView({Key? key}) : super(key: key);

  @override
  State<GPSConnectView> createState() => _GPSConnectViewState();
}

class _GPSConnectViewState extends State<GPSConnectView> {
  late TextEditingController gpsNumberController = TextEditingController();
  late TextEditingController gpsCodeController = TextEditingController();
  late TextEditingController birthDateController = TextEditingController();
  late TextEditingController nameController = TextEditingController();
  late TextEditingController additionalInfoController = TextEditingController();
  late TextEditingController pictureController = TextEditingController();
  late GpsUserState userState = GpsUserState.child;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final state = context.watch<AuthenticationState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Connect a GPS".toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FieldInput(
                    title: "GPS Code",
                    controller: gpsCodeController,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FieldInput(
                    title: "GPS SIM Number",
                    controller: gpsNumberController,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "This GPS will be used for",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            nameController.text = "";
                            additionalInfoController.text = "";
                            birthDateController.text = "";
                            pictureController.text = "";
                            setState(() {
                              userState = GpsUserState.child;
                            });
                          },
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(13)),
                            elevation: const MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(
                                userState == GpsUserState.child
                                    ? kPrimaryColor
                                    : Colors.blue[50]),
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10)),
                              ),
                            ),
                          ),
                          child: Text(
                            "Child",
                            style: TextStyle(
                              color: userState == GpsUserState.child
                                  ? Colors.white
                                  : kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            nameController.text = "";
                            additionalInfoController.text = "";
                            birthDateController.text = "";
                            pictureController.text = "";
                            setState(() {
                              userState = GpsUserState.object;
                            });
                          },
                          style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(13)),
                            elevation: const MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(
                                userState == GpsUserState.object
                                    ? kPrimaryColor
                                    : Colors.blue[50]),
                            shape: const MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(10)),
                              ),
                            ),
                          ),
                          child: Text("Object",
                              style: TextStyle(
                                  color: userState == GpsUserState.object
                                      ? Colors.white
                                      : kTextColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ), // Espacement entre les champs

                  const SizedBox(height: 20),

                  FieldInput(
                    title: userState == GpsUserState.child
                        ? "Child Full Name"
                        : "Object name",
                    controller: nameController,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  if (userState == GpsUserState.child)
                    const SizedBox(height: 20),
                  if (userState == GpsUserState.child)
                    FieldInput(
                      title: "Child Birth Date",
                      controller: birthDateController,
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),

                  const SizedBox(height: 20),
                  FieldInput(
                    title: "Additional information",
                    minLines: 1,
                    maxLines: 4,
                    controller: additionalInfoController,
                    inputType: TextInputType.multiline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.black54),
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.all(13)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add a Picture",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll(kPrimaryColor),
                              padding: const MaterialStatePropertyAll(
                                  EdgeInsets.all(13)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "CONNECT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum GpsUserState {
  child,
  object,
}
