import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 70, left: 15, right: 15, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back)),
                const SizedBox(width: 15),
                const Text(
                  "Forgot Password ?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Form(
              key: _formkey,
              child: TextFormField(
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
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                passwordReset();
              },
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xff6b3fa0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  passwordReset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
