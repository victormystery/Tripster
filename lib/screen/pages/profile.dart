// ignore_for_file: use_build_context_synchronously

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:tripster/services/providers/auth_service.dart';

import '../../services/auth/login.dart';
import '../../services/providers/helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = "";
  AuthService authService = AuthService();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 29,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const CircleAvatar(radius: 32),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, $userName'),
                    const SizedBox(height: 5),
                    const Text('Lagos, Nigeria')
                  ],
                )
              ],
            ),
            const SizedBox(height: 41),
            personalInfo(),
            const SizedBox(height: 25),
            notify(),
            const SizedBox(height: 25),
            faq(),
            const SizedBox(height: 25),
            language(),
            const SizedBox(height: 25),
            logout(),
          ],
        ),
      ),
    );
  }

  personalInfo() {
    return Container(
      width: 355,
      height: 58,
      padding: const EdgeInsets.only(
        top: 19,
        left: 24,
        right: 25,
        bottom: 19,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color.fromARGB(255, 16, 16, 17)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              color: Color(0xFF8460B0),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(Icons.person_outline)
        ],
      ),
    );
  }

  notify() {
    return Container(
      width: 355,
      height: 58,
      padding: const EdgeInsets.only(
        top: 19,
        left: 24,
        right: 25,
        bottom: 19,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color.fromARGB(255, 16, 16, 17)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Notification',
            style: TextStyle(
              color: Color(0xFF8460B0),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(Icons.notifications_none_outlined)
        ],
      ),
    );
  }

  faq() {
    return Container(
      width: 355,
      height: 58,
      padding: const EdgeInsets.only(
        top: 19,
        left: 24,
        right: 25,
        bottom: 19,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color.fromARGB(255, 16, 16, 17)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'FAQ',
            style: TextStyle(
              color: Color(0xFF8460B0),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(CommunityMaterialIcons.chat_question)
        ],
      ),
    );
  }

  language() {
    return Container(
      width: 355,
      height: 58,
      padding: const EdgeInsets.only(
        top: 19,
        left: 24,
        right: 25,
        bottom: 19,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color.fromARGB(255, 16, 16, 17)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Language',
            style: TextStyle(
              color: Color(0xFF8460B0),
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(CommunityMaterialIcons.globe_light)
        ],
      ),
    );
  }

  logout() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          elevation: 1,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Are you sure you want to log out of $userName‘s account ',
                  style: const TextStyle(
                    color: Color(0xFF5D6B82),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await authService.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: Container(
                          width: 162,
                          height: 54,
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 53,
                            right: 54,
                            bottom: 17,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 133, 135, 140)),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Color(0xFF15294B),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 162,
                        height: 54,
                        padding: const EdgeInsets.only(
                          top: 18,
                          left: 53,
                          right: 54,
                          bottom: 17,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF6B3FA0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        );
      },
      child: Container(
        width: 355,
        height: 58,
        padding: const EdgeInsets.only(
          top: 19,
          left: 24,
          right: 25,
          bottom: 19,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color.fromARGB(255, 16, 16, 17)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(
            color: Color(0xFF8460B0),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
