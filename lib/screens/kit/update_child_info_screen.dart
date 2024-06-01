import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/kit/blocs/get_children/get_children_bloc.dart';
import 'package:heldis/screens/kit/blocs/handle_child/handle_child_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:heldis/screens/kit/model/get_all_child_response_model.dart';

class UpdateChildInfoScreen extends StatefulWidget {
  const UpdateChildInfoScreen(
      {super.key, this.canPop = false, required this.child});
  final ChildModel child;
  final bool canPop;

  @override
  State<UpdateChildInfoScreen> createState() => _UpdateChildInfoScreenState();
}

class _UpdateChildInfoScreenState extends State<UpdateChildInfoScreen> {
  late TextEditingController gpsNumberController;
  late TextEditingController gpsCodeController;
  late TextEditingController birthDateController;
  late TextEditingController nameController;
  late TextEditingController additionalInfoController;
  late ChildModel _child;
  String image = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _child = widget.child;
    gpsNumberController =
        TextEditingController(text: widget.child.gps?.simNumber);
    gpsCodeController =
        TextEditingController(text: widget.child.gps?.simNumber);
    birthDateController = TextEditingController(text: widget.child.birthDate);
    nameController = TextEditingController(text: widget.child.name);
    additionalInfoController =
        TextEditingController(text: widget.child.description);

    image = widget.child.avatar ?? '';
  }

  @override
  Widget build(BuildContext context) {
    //final state = context.watch<AuthenticationState>();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<HandleChildBloc, HandleChildState>(
              listener: (context, state) {
                if (state is UpdateChildInfoSuccess) {
                  showSuccessSnackBar(
                      context: context, message: "Child Information updated");
                  context.read<GetChildrenBloc>().add(const GetChildren());
                }

                if (state is UpdateChildInfoError) {
                  showErrorSnackBar(
                    context: context,
                    message: state.message,
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
                            readOnly: true,
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
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
                          FieldInput(
                            title: "Child Full Name",
                            controller: nameController,
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
                                      context.read<HandleChildBloc>().add(
                                            UpdateChildInfoEvent(
                                              childId: widget.child.id ?? 0,
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
                                      if (context.watch<HandleChildBloc>().state
                                          is UpdateChildInfoLoading)
                                        const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      if (context.watch<HandleChildBloc>().state
                                          is UpdateChildInfoLoading)
                                        const SizedBox(width: 10),
                                      const Text(
                                        "Update",
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
