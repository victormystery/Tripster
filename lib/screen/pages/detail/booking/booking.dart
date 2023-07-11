import 'package:flutter/material.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 70, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_outlined),
                ),
                SizedBox(width: 40),
                Text(
                  'Detail Booking',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF243757),
                    fontSize: 22,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
