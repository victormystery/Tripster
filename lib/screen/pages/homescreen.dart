// ignore_for_file: must_be_immutable

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import 'package:tripster/services/providers/auth_service.dart';

import '../../services/providers/helper.dart';
import '../../widget/place/popular_card.dart';
import '../../widget/rating.dart';
import '../../widget/widget.dart';
import 'detail/details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "";
  AuthService authService = AuthService();

  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    // await HelperFunctions.getUserEmailSf().then((value) {
    //   setState(() {
    //     email = value!;
    //   });
    // });
    await HelperFunctions.getUserNameSf().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.notifications_none_outlined,
                    size: 32,
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                "Where do you want to explore today ?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: const BoxDecoration(),
                child: SearchBar(
                  
                  controller: _search,
                  hintText: 'Search destination',
                  trailing: const [Icon(Icons.search)],
                  // leading: Icon(Icons.search),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Favorite Place",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Explore",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 32, 86),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              SizedBox(
                height: 255,
                child: ListView.separated(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 27),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      return nextScreen(
                          context,
                          DetailScreen(
                            index: index,
                          ));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 195,
                          height: 255,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/place${index + 1}.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 150,
                          top: 13,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: OvalBorder(),
                            ),
                            child: Icon(
                              CommunityMaterialIcons.heart,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: -59,
                          child: Text(
                            'Ketu Beach',
                            style: TextStyle(
                              color: Color(0xFFFAF6FA),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 24,
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
                            decoration: BoxDecoration(),
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 25,
                          top: 193,
                          child: Container(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 24,
                                ),
                                Text(
                                  'Lagos, Nigeria',
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
                        ),
                        Positioned(
                          left: 25,
                          bottom: 20,
                          child: Row(
                            children: [
                              Rating(
                                rating: 4.6,
                                ratingCount: 12,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '4.6',
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
                ),
              ),

              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular packages",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "see all",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 32, 86),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              PopularCard(),

             
            ],
          ),
        ),
      ),
    );
  }
}
