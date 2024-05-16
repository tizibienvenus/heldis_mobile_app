import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/kit_screen.dart';
import 'package:heldis/screens/layout/check_connection_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController passwordConfirmController =
      TextEditingController();
  late TextEditingController passwordController = TextEditingController();

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
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 75,
                ),
                Text(
                  "Register",
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
                          inputType: TextInputType.text,
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
                          inputType: TextInputType.text,
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
                        Text(
                          "Phone format : +(country code)phone number",
                          style: TextStyle(color: Colors.black87, fontSize: 12),
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        FieldInput(
                          title: "Password",
                          controller: passwordController,
                          inputType: TextInputType.text,
                          obscureText: true,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        FieldInput(
                          title: "Confirm Password",
                          controller: passwordConfirmController,
                          inputType: TextInputType.text,
                          obscureText: true,
                          maxLines: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password';
                            }

                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 2,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: BlocListener<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is RegisterSuccess) {
                                    Navigator.pop(context);
                                  }

                                  if (state is RegisterError) {
                                    showErrorSnackBar(
                                      context: context,
                                      message: state.message,
                                    );
                                  }
                                },
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
                                      context.read<AuthBloc>().add(
                                            RegisterEvent(
                                              name: nameController.text,
                                              phone: phoneController.text,
                                              avatar: "",
                                              email: emailController.text,
                                              password: passwordController.text,
                                            ),
                                          );
                                    }
                                  },
                                  child: context.watch<AuthBloc>().state
                                          is RegisterLoading
                                      ? SizedBox(
                                          width: 22,
                                          height: 22,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                          ))
                                      : const Text("Register"),
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
      ),
    );
  }
}
