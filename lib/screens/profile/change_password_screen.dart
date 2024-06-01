import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heldis/common/FieldInput.dart';
import 'package:heldis/common/tools.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/screens/authentification/presentation/blocs/auth/auth_bloc.dart';
import 'package:heldis/screens/authentification/presentation/blocs/get_user/get_user_bloc.dart';
import 'package:heldis/screens/profile/blocs/handle_profile/handle_profile_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
                "Change Password",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 40,
              ),
              BlocListener<HandleProfileBloc, HandleProfileState>(
                listener: (context, state) {
                  print(state);
                  if (state is UpdatePasswordSuccess) {
                    showSuccessSnackBar(
                      context: context,
                      message: "Password updated successfully",
                    );
                  }

                  if (state is UpdatePasswordError) {
                    showErrorSnackBar(
                      context: context,
                      message: state.message,
                    );
                  }
                },
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FieldInput(
                          title: "Old Password",
                          controller: oldPasswordController,
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
                          title: "New Password",
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
                        const SizedBox(
                          height: kDefaultPadding * 2,
                        ),
                        Row(
                          children: [
                            Expanded(
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
                                          UpdatePasswordEvent(
                                            oldPassword:
                                                oldPasswordController.text,
                                            newPassword:
                                                passwordController.text,
                                            confirmPassword:
                                                passwordConfirmController.text,
                                          ),
                                        );
                                  }
                                },
                                child: context.watch<HandleProfileBloc>().state
                                        is UpdatePasswordLoading
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
}
