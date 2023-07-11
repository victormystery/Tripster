import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:tripster/widget/rating.dart';

class SecondDetailPage extends StatelessWidget {
  final Animation<double> transitionAnimation;
  final int i;
  SecondDetailPage(
      {required this.transitionAnimation, required this.i, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 70, right: 20, left: 20),
        child: AnimatedBuilder(
          animation: transitionAnimation,
          builder: (context, child) {
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(0.0, 0.1), end: Offset.zero)
                  .animate(transitionAnimation),
              child: child,
            );
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_outlined),
                    ),
                    Text(
                      'Ketu Beach',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF243757),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                      CommunityMaterialIcons.heart,
                      color: Colors.red,
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 340,
                  height: 240,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/place${i + 1}.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 10,
                        top: 20,
                        child: Image.asset('images/badge.png'),
                      ),
                      Positioned(
                        left: 15,
                        top: 70,
                        child: Text(
                          'Ketu Beach',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 120,
                        child: Container(
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
                      ),
                      Positioned(
                        left: 15,
                        bottom: 30,
                        child: Rating(
                          rating: 4.8,
                          ratingCount: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                about(),
                SizedBox(height: 25),
                gallery(),
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
                              color: Colors.red,
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '/Person',
                            style: TextStyle(
                              color: Colors.grey,
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  about() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Trip',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF354764),
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15),
        Text(
          'Ketu is an island in Nigerua known for its verdant'
          ' volcanoes unique rice terraces, beaches and beautiful'
          ' coral refs, Before becoming a tourist attraction,'
          ' Ketu was a trading port wherelocal products were traded'
          ' to buyers from outside Nigeria',
          style: TextStyle(
            color: Color(0xFF15294B),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 10),
        Text(
          'See beautiful Ketu and help us keep it that way by joining'
          'this EcoTour of a Ketu village. All proceeds from tripster are'
          'donated to the Tangkas Village Recycling Center Expert'
          'Friendly Service.',
          style: TextStyle(
            color: Color(0xFF15294B),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.justify,
        )
      ],
    );
  }

  gallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gallery Photo',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF354764),
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: 240,
          height: 110,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 15),
            itemCount: 2,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 98,
                height: 110,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/gallery/frame${index + 1}.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}
