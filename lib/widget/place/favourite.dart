import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../screen/pages/detail/details.dart';
import '../rating.dart';
import '../widget.dart';

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                height: 255,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('places')
                        .where('isFavourite', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 27),
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                return GestureDetector(
                                  onTap: () {
                                    if (snapshot.hasData) {
                                      return nextScreen(
                                          context,
                                          DetailScreen(
                                            data: snapshot.data!,
                                            index: index,
                                          ));
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 195,
                                        height: 255,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(data['imageUrl']),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 150,
                                        top: 13,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const ShapeDecoration(
                                            color: Colors.white,
                                            shape: OvalBorder(),
                                          ),
                                          child: const Icon(
                                            CommunityMaterialIcons.heart,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 25,
                                        top: -59,
                                        child: Text(
                                          data['name'],
                                          style: const TextStyle(
                                            color: Color(0xFFFAF6FA),
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 22,
                                        top: 194,
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: const BoxDecoration(),
                                          child: const Icon(
                                            Icons.location_on_outlined,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 25,
                                        top: 193,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 24,
                                            ),
                                            Text(
                                              data['location'],
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
                                      Positioned(
                                        left: 25,
                                        bottom: 20,
                                        child: Row(
                                          children: [
                                            Rating(
                                              rating: data['rating'],
                                              ratingCount: 12,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              data['rating'].toString(),
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
                                );
                              },
                            );
                    }),
              );
  }
}