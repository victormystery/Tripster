import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:tripster/screen/pages/detail/second_detail.dart';

import '../../../widget/widget.dart';
import 'booking/booking.dart';

class DetailScreen extends StatelessWidget {
  final QuerySnapshot data;
  final int index;
  DetailScreen({required this.index, required this.data, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('places')
              .where('isFavourite', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No data available');
            }

            final data = snapshot.data!;
            final imageUrl = data.docs[index]['imageUrl'];
            final name = data.docs[index]['name'];
            final location = data.docs[index]['location'];
            final description = data.docs[index]['description'];
            final rating = data.docs[index]['rating'].toString();
            final price = data.docs[index]['price'].toString();

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
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
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.yellow,
                              size: 32,
                            )),
                        const Icon(
                          CommunityMaterialIcons.heart,
                          color: Colors.red,
                        )
                      ],
                    ),
                    const SizedBox(height: 150),
                    SizedBox(
                      width: 163,
                      height: 24,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'FAVOURITE PLACE',
                            style: TextStyle(
                              color: Colors.orange,
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
                            decoration: const BoxDecoration(),
                            child: Image.asset('images/badge.png'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 39,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.51,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
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
                            location,
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
                    const SizedBox(height: 30),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
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
                              SizedBox(width: 10),
                              Text(
                                rating,
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
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return SecondDetailPage(
                                  transitionAnimation: animation,
                                  i: index,
                                  data: snapshot.data!,
                                );
                              },
                              transitionDuration: const Duration(seconds: 1),
                            ));
                          },
                          child: const Icon(
                            Icons.arrow_downward_outlined,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\₦$price ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
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
                            nextScreen(
                                context, BookingDetails(tripPrice: price));
                          },
                          child: Container(
                            width: 180,
                            height: 54,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF6B3FA0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Center(
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
            );
          },
        ),
      ),
    );
  }
}
