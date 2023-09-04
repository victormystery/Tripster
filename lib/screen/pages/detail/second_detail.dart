import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:tripster/widget/rating.dart';

import '../../../widget/widget.dart';
import 'booking/booking.dart';

class SecondDetailPage extends StatelessWidget {
  final Animation<double> transitionAnimation;
  final QuerySnapshot data;
  final int i;
  const SecondDetailPage({
    required this.transitionAnimation,
    required this.data,
    required this.i,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
        child: AnimatedBuilder(
          animation: transitionAnimation,
          builder: (context, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero)
                      .animate(transitionAnimation),
              child: child,
            );
          },
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('places')
                  .where('isFavourite', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back_outlined),
                            ),
                            Text(
                              snapshot.data!.docs[i]['name'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF243757),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Icon(
                              CommunityMaterialIcons.heart,
                              color: Colors.red,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 340,
                          height: 240,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  snapshot.data!.docs[i]['imageUrl']),
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
                                top: 60,
                                child: Text(
                                  snapshot.data!.docs[i]['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 11, 8, 208),
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 15,
                                top: 110,
                                child: SizedBox(
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
                                        snapshot.data!.docs[i]['location'],
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
                                child: Row(
                                  children: [
                                    Rating(
                                      rating: snapshot.data!.docs[i]['rating'],
                                      ratingCount: 12,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      snapshot.data!.docs[i]['rating']
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        about(snapshot.data!),
                        const SizedBox(height: 25),
                        buildGallery(snapshot.data!, context),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '\₦${snapshot.data!.docs[i]['price'].toString()}  ',
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
                                nextScreen(
                                    context,
                                    BookingDetails(
                                      tripPrice: snapshot.data!.docs[i]['price']
                                          .toString(),
                                    ));
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  about(QuerySnapshot snapshot) {
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
          snapshot.docs[i]['description'],
          style: TextStyle(
            color: Color(0xFF15294B),
            fontSize: 19,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget buildGallery(QuerySnapshot snapshot, BuildContext context) {
    List<Widget> imageWidgets = [];

    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      var galleryImages = data['galleryImages'];

      for (var imageUrl in galleryImages) {
        imageWidgets.add(
          _buildImageContainer(imageUrl),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Gallery Photo',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF354764),
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 110,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: imageWidgets.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return imageWidgets[index];
            },
          ),
        ),
      ],
    );
  }

  Container _buildImageContainer(String imageUrl) {
    return Container(
      width: 98,
      height: 110,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
