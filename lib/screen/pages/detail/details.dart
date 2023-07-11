import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:tripster/screen/pages/detail/second_detail.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  DetailScreen({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/place${index + 1}.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Icon(
                    CommunityMaterialIcons.heart,
                    color: Colors.red,
                  )
                ],
              ),
              SizedBox(height: 150),
              Container(
                width: 163,
                height: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'FAVOURITE PLACE',
                      style: TextStyle(
                        color: Color(0xFFFAF6FA),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 11),
                    Container(
                      width: 24,
                      height: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Image.asset('images/badge.png'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Ketu Beach',
                style: TextStyle(
                  color: Color(0xFFFAF6FA),
                  fontSize: 39,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3.51,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 130,
                height: 24,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Lagos, Nigeria',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Ketu is an island in Nigerua known for its verdant'
                ' volcanoes unique rice terraces, beaches and beautiful'
                ' coral refs, Before becoming a tourist attraction,'
                ' Ketu was a trading port wherelocal products were traded'
                ' to buyers from outside Nigeria',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 62,
                    height: 25,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '4.8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return SecondDetailPage(
                            transitionAnimation: animation,
                            i: index,
                          );
                        },
                        transitionDuration: Duration(seconds: 1),
                      ));
                    },
                    child: Icon(
                      Icons.arrow_downward_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '\$25.00 ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: '/Person',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Container(
                      width: 180,
                      height: 54,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFF6B3FA0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Booking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
