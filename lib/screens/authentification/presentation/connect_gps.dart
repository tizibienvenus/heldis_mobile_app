import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/register_kit/register_kit_bloc.dart';
import 'package:heldis/screens/home.dart';
import 'package:heldis/screens/home/home_page.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/screens/layout/check_connection_screen.dart';
import 'package:image_picker/image_picker.dart';

class GPSConnectView extends StatefulWidget {
  GPSConnectView({Key? key, this.canPop = false}) : super(key: key);

  final bool canPop;

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
  String image = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final state = context.watch<AuthenticationState>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<RegisterKitBloc, RegisterKitState>(
              listener: (context, state) {
                if (state is RegisterKitSuccess) {
                  context.read<GetUserBloc>().add(const GetUser());
                  context.read<GetChildrenBloc>().add(const GetChildren());
                }

                if (state is RegisterKitError) {
                  showErrorSnackBar(
                    context: context,
                    message: state.message,
                  );
                }
              },
            ),
            BlocListener<GetUserBloc, GetUserState>(
              listener: (context, state) {
                if (state is GetUserSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: context.watch<GetUserBloc>().state is GetUserLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
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
                            height: 30,
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
                          // FieldInput(
                          //   title: "GPS SIM Number",
                          //   controller: gpsNumberController,
                          //   inputType: TextInputType.text,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'This field is required';
                          //     }
                          //     return null;
                          //   },
                          // ),
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
                                    elevation:
                                        const MaterialStatePropertyAll(0),
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
                                    showWarningSnackBar(
                                        context: context,
                                        message: "Coming soon...");
                                    return;
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
                                    elevation:
                                        const MaterialStatePropertyAll(0),
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
                                          color:
                                              userState == GpsUserState.object
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
                              readOnly: true,
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (date != null) {
                                  birthDateController.text =
                                      date.toString().split(" ").first;
                                }
                              },
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
                          if (image.isEmpty)
                            FieldInput(
                              title: "Pick image",
                              controller: null,
                              readOnly: true,
                              onTap: () {
                                pickImage(context);
                              },
                              validator: (value) {
                                return null;
                              },
                            ),
                          if (image != "")
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  pickImage(context);
                                },
                                child: Image.memory(base64Decode(image),
                                    width: 200, height: 200, fit: BoxFit.cover),
                              ),
                            ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              kPrimaryColor),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.all(13)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<RegisterKitBloc>().add(
                                            RegisterKitSubmitEvent(
                                              name: nameController.text,
                                              avatar: image,
                                              birthDate:
                                                  birthDateController.text,
                                              gpsSimNumber:
                                                  gpsCodeController.text,
                                              description:
                                                  additionalInfoController.text,
                                            ),
                                          );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (context.watch<RegisterKitBloc>().state
                                          is RegisterKitLoading)
                                        const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      if (context.watch<RegisterKitBloc>().state
                                          is RegisterKitLoading)
                                        const SizedBox(width: 10),
                                      const Text(
                                        "CONNECT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
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
      ),
    );
  }

  Future<dynamic> pickImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Pick an image'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? _image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (_image == null) {
                  return;
                }
                List<int> imageBytes = File(_image.path).readAsBytesSync();
                final imageBase64 = base64Encode(imageBytes);
                setState(() {
                  image = imageBase64;
                });
                Navigator.pop(context);
              },
              child: const Text('Camera'),
            ),
            SimpleDialogOption(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? _image = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (_image == null) {
                  return;
                }
                List<int> imageBytes = File(_image.path).readAsBytesSync();
                final imageBase64 = base64Encode(imageBytes);
                setState(() {
                  image = imageBase64;
                });
                Navigator.pop(context);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }
}

enum GpsUserState {
  child,
  object,
}
