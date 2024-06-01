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
import 'package:heldis/screens/authentification/presentation/register_screen.dart';
import 'package:heldis/screens/layout/check_connection_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final state = context.watch<AuthenticationState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                    "Login",
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
                        children: [
                          Row(children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showWarningSnackBar(
                                      context: context,
                                      message: "Feature coming soon");
                                },
                                style: ButtonStyle(
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.all(13)),
                                  elevation: const MaterialStatePropertyAll(0),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.blue[50]),
                                  shape: const MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(10)),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Phone",
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: const ButtonStyle(
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.all(13)),
                                  elevation: MaterialStatePropertyAll(0),
                                  backgroundColor:
                                      MaterialStatePropertyAll(kPrimaryColor),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(10)),
                                    ),
                                  ),
                                ),
                                child: const Text("Email",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ]), // Espacement entre les champs
                          const SizedBox(
                            height: 75,
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
                            height: kDefaultPadding * 2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: BlocListener<AuthBloc, AuthState>(
                                  listener: (context, state) {
                                    if (state is LoginSuccess) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckConnectionScreen(),
                                        ),
                                        (route) => false,
                                      );
                                    }

                                    if (state is LoginError) {
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                              LoginEvent(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              ),
                                            );
                                      }
                                    },
                                    child: context.watch<AuthBloc>().state
                                            is LoginLoading
                                        ? SizedBox(
                                            width: 22,
                                            height: 22,
                                            child:
                                                const CircularProgressIndicator(
                                              color: Colors.white,
                                            ))
                                        : const Text("CONTINUE"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Color.fromARGB(255, 58, 58, 58)),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.all(13)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("CREATE ACCOUNT"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black12,
                          ),
                          const SizedBox(
                            height: kDefaultPadding,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FilledButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.black12),
                                      padding: const MaterialStatePropertyAll(
                                          EdgeInsets.all(13)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  onPressed: () {
                                    showWarningSnackBar(
                                        context: context,
                                        message: "Feature coming soon");
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/google.svg"),
                                      const SizedBox(
                                        width: kDefaultPadding,
                                      ),
                                      const Text(
                                        "Connect with Google",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
