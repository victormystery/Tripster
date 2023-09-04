// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tripster/services/providers/auth_service.dart';
import 'package:tripster/widget/place/favourite.dart';

import '../../services/providers/helper.dart';
import '../../widget/place/popular_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userName = "";
  String name = "";
  AuthService authService = AuthService();

  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
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
                        "Welcome, $userName",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const Icon(
                    Icons.notifications_none_outlined,
                    size: 32,
                  )
                ],
              ),
              const SizedBox(height: 17),
              const Text(
                "Where do you want to explore today ?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              // Container(
              //   decoration: const BoxDecoration(),
              //   child: SearchBar(
              //     controller: _search,
              //     hintText: 'Search destination',
              //     trailing: const [Icon(Icons.search)],
              //     onChanged: (value) {
              //       setState(() {
              //         name = value;
              //       });
              //     },
              //   ),
              // ),
              // Container(
              //   height: 300,
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('places')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       return (snapshot.connectionState == ConnectionState.waiting)
              //           ? Center(
              //               child: CircularProgressIndicator(),
              //             )
              //           : ListView.builder(
              //               itemCount: snapshot.data!.docs.length,
              //               itemBuilder: (context, index) {
              //                 var data = snapshot.data!.docs[index].data()
              //                     as Map<String, dynamic>;

              //                 if (name.isEmpty) {
              //                   return Container();
              //                 }

              //                 if (data['name']
              //                     .toString()
              //                     .startsWith(name.toUpperCase())) {
              //                   return ListTile(
              //                     title: Text(
              //                       data['name'],
              //                       maxLines: 1,
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                         color: Colors.black54,
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                     subtitle: Text(
              //                       data['location'],
              //                       maxLines: 1,
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                         color: Colors.black54,
              //                         fontSize: 16,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                     leading: CircleAvatar(
              //                       backgroundImage:
              //                           NetworkImage(data['imageUrl']),
              //                     ),
              //                   );
              //                 }
              //                 return Container();
              //               },
              //             );
              //     },
              //   ),
              // ),
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
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Explore",
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 32, 86),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              FavouriteCard(),
              const SizedBox(height: 10),
              const PopularCard(),
            ],
          ),
        ),
      ),
    );
  }
}
