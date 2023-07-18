// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tripster/screen/home/home.dart';
import 'package:tripster/services/auth/login.dart';
import 'package:tripster/services/providers/auth_service.dart';
import 'package:tripster/widget/auth/forgot.dart';

import '../../widget/widget.dart';
import '../providers/helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();
  bool isChecked = false;
  bool _isLoading = false;
  String password = "";
  String email = "";
  String username = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.red,
              ),
            )
          : Material(
              child: Padding(
                padding: const EdgeInsets.only(top: 70, right: 10, left: 10),
                child: SingleChildScrollView(
                  child: Column(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Column(
                        children: [
                          Image.asset("images/compass.png"),
                          const Text(
                            "Tripster",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 28),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Enter your Email",
                                    prefixIcon: const Icon(Icons.email)),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  setState(() {
                                    username = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isNotEmpty) {
                                    return null;
                                  }
                                  return "Enter a username";
                                },
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Enter your Full Name",
                                    prefixIcon: const Icon(Icons.person)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: textInputDecoration.copyWith(
                                  hintText: 'Password',
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 7) {
                                    return 'Password must be at least 7 characters long.';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              nextScreen(context, const ForgotPassword());
                            },
                            child: const Text("forgot password?"),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () async {
                          signup();
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(4.11, 0, 9.5, 40),
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffb3b9c4),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              'Create Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff354764),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              nextScreenReplace(context, const LoginPage());
                            },
                            child: const Text("Login"),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 6.39, 15),
                        child: const Center(
                          child: Text(
                            'Or Sign Up With',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset("images/google.png"),
                          ),
                          const SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset("images/instagram.png"),
                          ),
                          const SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {},
                            child: Image.asset("images/facebook.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  signup() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(email, username, password)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSf(email);
          await HelperFunctions.saveUserNameSf(username);

          nextScreenReplace(context, const HomeScreen());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
