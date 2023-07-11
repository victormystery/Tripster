import 'package:flutter/material.dart';

class MyTrip extends StatelessWidget {
  const MyTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchTrip = TextEditingController();
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 70, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List Your Trip',
              style: TextStyle(
                color: Colors.black,
                fontSize: 29,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 15),
            Container(
              decoration: const BoxDecoration(),
              child: SearchBar(
                shape: MaterialStatePropertyAll(LinearBorder(
                  side: BorderSide(width: 1, style: BorderStyle.solid),
                )),
                controller: _searchTrip,
                hintText: 'Search destination',
                trailing: const [Icon(Icons.search)],
              ),
            ),
            SizedBox(height: 15),
            
          ],
        ),
      ),
    );
  }
}
