import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/profile/blocs/handle_profile/handle_profile_bloc.dart';
import 'package:heldis/services/session/connexion/connexion_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  String image = "";

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (context.read<GetUserBloc>().state is GetUserSuccess) {
      nameController.text =
          (context.read<GetUserBloc>().state as GetUserSuccess).user.name ?? "";
      emailController.text =
          (context.read<GetUserBloc>().state as GetUserSuccess).user.email ??
              "";
      phoneController.text =
          (context.read<GetUserBloc>().state as GetUserSuccess).user.phone ??
              "";

      image =
          (context.read<GetUserBloc>().state as GetUserSuccess).user.avatar ??
              "";
    }
  }

  @override
  Widget build(BuildContext context) {
    //final state = context.watch<AuthenticationState>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                "Edit Profile",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldInput(
                        title: "Name",
                        controller: nameController,
                        inputType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      FieldInput(
                        title: "Email",
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      FieldInput(
                        title: "Phone",
                        controller: phoneController,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const Text(
                        "Phone format : +(country code)phone number",
                        style: TextStyle(color: Colors.black87, fontSize: 12),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
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
                      const SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MultiBlocListener(
                              listeners: [
                                BlocListener<GetUserBloc, GetUserState>(
                                  listener: (context, state) {
                                    if (state is GetUserSuccess) {
                                      context
                                          .read<ConnexionBloc>()
                                          .add(ConnexionLoadEvent(
                                            user: state.user,
                                            token: box.read('token'),
                                          ));
                                    }
                                  },
                                ),
                                BlocListener<HandleProfileBloc,
                                    HandleProfileState>(
                                  listener: (context, state) {
                                    print(state);
                                    if (state is UpdateProfileSuccess) {
                                      showSuccessSnackBar(
                                          context: context,
                                          message: "Update profile success");
                                      context
                                          .read<GetUserBloc>()
                                          .add(const GetUser());
                                    }

                                    if (state is UpdateProfileError) {
                                      showErrorSnackBar(
                                          context: context,
                                          message: state.message);
                                    }
                                  },
                                ),
                              ],
                              child: FilledButton(
                                style: ButtonStyle(
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.all(13)),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<HandleProfileBloc>().add(
                                        UpdateProfileEvent(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            email: emailController.text,
                                            avatar: image));
                                  }
                                },
                                child: context.watch<HandleProfileBloc>().state
                                        is UpdateProfileLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text("Submit"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                    ],
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
