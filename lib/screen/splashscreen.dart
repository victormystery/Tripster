// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tripster/screen/home/home.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  HomeScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.0,
      child: Center(
        child: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            const SizedBox(height: 20),
            const Text("version 1.0.0+1"),
            const SizedBox(height: 348),
            Column(
              children: [
                Image.asset("images/compass.png"),
                const Text(
                  "tripster",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
