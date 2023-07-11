import 'package:flutter/material.dart';
import 'package:tripster/screen/home/home.dart';
import 'package:tripster/services/auth/signup.dart';
import 'package:tripster/services/providers/auth_service.dart';


import '../../widget/auth/forgot.dart';
import '../../widget/widget.dart';
import '../providers/database.dart';
import '../providers/helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  bool isChecked = false;
  bool _isLoading = false;
  String password = "";
  String email = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
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
                      const SizedBox(height: 30),
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
                                obscureText: true,
                                decoration: textInputDecoration.copyWith(
                                  labelText: "Password",
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
                      const SizedBox(height: 10),
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
                          login();
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(4.11, 0, 9.5, 40),
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xfffb3b9c4),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xfff6b3fa0)),
                          child: const Center(
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don/'t have an account? "),
                          GestureDetector(
                            onTap: () {
                              nextScreenReplace(context, const RegisterPage());
                            },
                            child: const Text("Register"),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 6.39, 15),
                        child: const Center(
                          child: Text(
                            'Or Login With',
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

  login() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginUserWithEmailAndPassword(email, password)
          .then((value) async {
        if (value == true) {
          await DatabaseService().getUserData(email);

          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSf(email);

          nextScreenReplace(context,  const HomeScreen());
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
