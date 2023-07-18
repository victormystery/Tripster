import 'package:flutter/material.dart';

class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Padding(
        padding: EdgeInsets.only(top: 70, right: 15, left: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back_outlined),
                SizedBox(width: 96),
                Text(
                  'Notification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF243757),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(height: 35),
            Text('Today'),
          ],
        ),
      ),
    );
  }

  noteTemplate() {
    return  Row(
        children: [
          CircleAvatar(child: Image.asset('images/solar-ticket-linear.svg'),),
          const SizedBox(width: 10),
          
        ],
      
    );
  }
}
