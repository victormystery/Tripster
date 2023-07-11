import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;
  final double size;
  int? ratingCount;
  Rating({required this.rating, this.ratingCount, this.size = 15});
  @override
  Widget build(BuildContext context) {
    List<Widget> _starList = [];

    int realNum = rating.floor();
    int partNum = ((rating - realNum) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNum) {
        _starList.add(Icon(Icons.star, color: Colors.amber, size: size));
      } else if (i == realNum) {
        _starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(Icons.star, color: Colors.amber, size: size),
              ClipRect(
                clipper: _Clipper(part: partNum),
                child: Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: size,
                ),
              )
            ],
          ),
        ));
      } else {
        _starList.add(Icon(Icons.star, color: Colors.grey, size: size));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _starList,
    );
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int part;
  _Clipper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
        (size.width / 10) * part, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}