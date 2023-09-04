import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:tripster/screen/pages/detail/details.dart';
import 'package:tripster/widget/widget.dart';

import '../../widget/rating.dart';

class MyTrip extends StatefulWidget {
  MyTrip({super.key});

  @override
  State<MyTrip> createState() => _MyTripState();
}

class _MyTripState extends State<MyTrip> {
  String name = "";
  final TextEditingController searchTrip = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'List Your Trip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 29,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: const BoxDecoration(),
                child: SearchBar(
                  shape: const MaterialStatePropertyAll(LinearBorder(
                    side: BorderSide(width: 1, style: BorderStyle.solid),
                  )),
                  controller: searchTrip,
                  hintText: 'Search destination',
                  trailing: const [Icon(Icons.search)],
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
              Container(
                height: 450,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('places')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                              if (name.isEmpty) {
                                return Container();
                              }

                              if (data['name']
                                  .toString()
                                  .startsWith(name.toUpperCase())) {
                                return SizedBox(
                                  child: GestureDetector(
                                    onTap: () {
                                      nextScreen(
                                          context,
                                          DetailScreen(
                                              index: index,
                                              data: snapshot.data!));
                                    },
                                    child: Container(
                                      width: 335,
                                      height: 160,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 2, 9, 17)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 15,
                                            top: 16,
                                            child: Container(
                                              width: 101,
                                              height: 128,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      data['imageUrl']),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 137,
                                            bottom: -30,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w400,
                                                    height: 19.20,
                                                  ),
                                                ),
                                                SizedBox(width: 43),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      Icon(
                                                        CommunityMaterialIcons
                                                            .heart_outline,
                                                        color: Colors.red,
                                                      );
                                                    });
                                                  },
                                                  child: Icon(
                                                      CommunityMaterialIcons
                                                          .heart_outline),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            left: 137,
                                            top: 55,
                                            child: Text(
                                              '\₦${data['price']}',
                                              style: TextStyle(
                                                color: Color(0xFFFF0000),
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 137,
                                            top: 83,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Rating(
                                                    rating: data['rating'],
                                                    ratingCount: 12),
                                                const SizedBox(width: 5),
                                                Text(
                                                  data['rating'].toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            left: 137,
                                            top: 109,
                                            child: Text(
                                              data['description'],
                                              style: TextStyle(
                                                color: Color(0xFF243757),
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              maxLines: 2,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
