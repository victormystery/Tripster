import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripster/screen/home/home.dart';
import 'package:tripster/widget/widget.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final String assetName = 'images/confirmed.svg';
    final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'Confirmed');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Material(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(16.0),
                width: 270,
                height: 310,
                child: svg),
            SizedBox(height: 15),
            Text(
              'Booking Successfully',
              style: TextStyle(
                color: Colors.black,
                fontSize: 29,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.42,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Get everything ready until it\'s time to go on a trip',
              style: TextStyle(
                color: Color(0xFF7A8699),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.67,
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                nextScreenReplace(context, HomeScreen());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Explore Other Places',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
